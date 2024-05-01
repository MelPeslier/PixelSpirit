shader_type canvas_item;

uniform float uv_resolution = 1.0;


uniform vec3 start_color : source_color;
uniform vec3 middle_color : source_color;
uniform vec3 end_color : source_color;


void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	//uv = uv * 2.0 * uv_resolution - uv_resolution;

	vec3 color = vec3(0.0);

	color = step(uv.x, 0.3334) * start_color;
	color += (step(uv.x, 0.6664) - step(uv.x, 0.3334) ) * middle_color;
	color += (1.0 - step(uv.x, 0.6664) ) * end_color;

	COLOR.rgb = color ;
	COLOR.a = 1.0;
}

