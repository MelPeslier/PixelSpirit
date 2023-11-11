shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	vec4 tex = texture(screen_texture, UV);
	COLOR.a = step(0.5,tex.r);
	COLOR.rgb = vec3(0.1, 0.8, 0.3);
}



