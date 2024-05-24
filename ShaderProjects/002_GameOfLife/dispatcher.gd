extends Node


@export_group("Settings")
@export_range(1, 1000) var update_frequency: int = 60
@export var auto_start : bool
@export var data_texture: Texture2D

@export_group("Requirements")
@export_file("*.glsl") var compute_shader_path: String
@export var renderer : ColorRect


var rd : RenderingDevice

var input_texture: RID
var output_texture: RID
var uniform_set: RID
var shader: RID
var pipeline: RID

var input_uniform: RDUniform
var output_uniform: RDUniform
var bindings: Array = []

var input_image: Image
var output_image: Image
var render_texture: ImageTexture

var input_format: RDTextureFormat
var output_format: RDTextureFormat
var processing: bool

#var texture_usage_storage_bit := RenderingDevice.TEXTURE_USAGE_STORAGE_BIT
#var texture_usage_can_update_bit := RenderingDevice.TEXTURE_USAGE_CAN_UPDATE_BIT
#var texture_usage_can_copy_from_bit := RenderingDevice.TEXTURE_USAGE_CAN_COPY_FROM_BIT

@onready var mat : ShaderMaterial = renderer.material
#region main loop

func _ready() -> void:
	create_and_validate_images()
	setup_compute_shader();

	if not auto_start: return
	start_process_loop()


func _input(event: InputEvent) -> void:
	if not event is InputEventKey: return
	if Input.is_action_just_pressed("ui_accept"):
		if processing:
			processing = false
		else:
			start_process_loop()


func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_PREDELETE:
		cleanup_gpu()
#endregion

#region image setup
	## <summary>
	## Merges the input image into the output image.
	## </summary>
	## <remarks>
	## This takes the input image and copies its pixel data into the output image.
	## It calculates start positions to center the input image in the output.
	##
	## It then copies pixel by pixel from the input to the output. It bounds checks each pixel
	## to ensure it will fit in the output image dimensions before setting it.
	##
	## Finally it sets the input image data to the output image data, to sync them.
	## </remarks>
	## <param name="outputWidth">The width of the output image</param>
	## <param name="outputHeight">The height of the output image</param>
	## <param name="inputWidth">The width of the input image</param>
	## <param name="inputHeight">The height of the input image</param>

func merge_images() -> void:
	var output_size := Vector2i(output_image.get_width(), output_image.get_height())
	var input_size := Vector2i(input_image.get_width(), input_image.get_height())

	# 1024 - 1024 = 0 :)
	var start := (output_size - input_size) / 2

	for x: int in range(input_size.x):
		for y: int in range(input_size.y):
			var color = input_image.get_pixel(x, y)
			var dest := start + Vector2i(x, y)
			if dest.x >= 0 and dest.x < output_size.x and dest.y >= 0 and dest.y < output_size.y:
				output_image.set_pixel(dest.x, dest.y, color)

	input_image.set_data(
		1024,
		1024,
		false,
		Image.FORMAT_L8,
		output_image.get_data()
	);

func link_output_texture_to_render() -> void:
	render_texture = ImageTexture.create_from_image(output_image)
	mat.set_shader_parameter("binaryDataTexture", render_texture)


func create_and_validate_images() -> void:
	output_image = Image.create(1024, 1024, false, Image.FORMAT_L8)
	if not data_texture:
		var noise := FastNoiseLite.new()
		noise.frequency = 0.1
		var noise_image: Image = noise.get_image(1024, 1024)
		input_image = noise_image
	else:
		input_image = data_texture.get_image()

	merge_images()
	link_output_texture_to_render()
#endregion

#region ComputeShader

func create_rendering_device() -> void:
	rd = RenderingServer.create_local_rendering_device()

	if rd == null:
		OS.alert("""Couldn't create local RenderingDevice on GPU: %s

Note: RenderingDevice is only available in the Forward+ and Mobile rendering methods, not Compatibility.""" % RenderingServer.get_video_adapter_name())

func create_shader() -> void:
	var shader_file : RDShaderFile = load(compute_shader_path)
	var shader_spirv: RDShaderSPIRV = shader_file.get_spirv()
	shader = rd.shader_create_from_spirv(shader_spirv)

func create_pipeline() -> void:
	pipeline = rd.compute_pipeline_create(shader)

func default_texture_format() -> RDTextureFormat:
	var tex := RDTextureFormat.new()
	tex.height = 1024
	tex.width  = 1024
	tex.format = RenderingDevice.DATA_FORMAT_R8_UNORM
	return tex

func create_texture_formats() -> void:
	input_format = default_texture_format()
	output_format = default_texture_format()

func create_texture_and_uniform(image: Image, format: RDTextureFormat, binding: int) -> RID:
	var view := RDTextureView.new()
	var data := image.get_data()
	var texture := rd.texture_create(format, view, data)
	var uniform := RDUniform.new()
	uniform.uniform_type = RenderingDevice.UNIFORM_TYPE_IMAGE
	uniform.binding = binding

	uniform.add_id(texture)
	bindings.append(uniform)
	return texture;

func create_uniforms() -> void:
	input_texture = create_texture_and_uniform(input_image, input_format, 0)
	output_texture = create_texture_and_uniform(output_image, output_format, 1)
	uniform_set = rd.uniform_set_create(bindings, shader, 0)

func setup_compute_shader() -> void:
	create_rendering_device()
	create_shader()
	create_pipeline()
	create_texture_formats()
	create_uniforms()
#endregion

#region process
func start_process_loop() -> void:
	var frq : int = 1000 / update_frequency
	processing = true
	while(processing):
		update()
		var timer := Timer.new()
		add_child(timer)
		timer.start(frq)
		await timer.timeout
		render()

func update() -> void:
	var compute_list : int = rd.compute_list_begin();
	rd.compute_list_bind_compute_pipeline(compute_list, pipeline)
	rd.compute_list_bind_uniform_set(compute_list, uniform_set, 0)
	rd.compute_list_dispatch(compute_list, 32, 32, 1)
	rd.compute_list_end()
	rd.submit()

func render() -> void:
	rd.sync()
	var bytes : PackedByteArray = rd.texture_get_data(output_texture, 0)
	rd.texture_update(input_texture, 0, bytes)
	output_image.set_data(1024, 1024, false, Image.FORMAT_L8, bytes)
	render_texture.update(output_image)

func cleanup_gpu() -> void:
	if not rd: return
	rd.free_rid(input_texture)
	rd.free_rid(output_texture)
	rd.free_rid(uniform_set)
	rd.free_rid(pipeline)
	rd.free_rid(shader)
	rd.free()
	rd = null

#endregion
