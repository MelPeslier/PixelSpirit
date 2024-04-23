shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/stroke/stroke.gdshaderinc"

group_uniforms square;
uniform float c;

void fragment() {
	//vec2 uv = (UV - 0.5) / uv_resolution;
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	uv = uv * 2.0 * uv_resolution - uv_resolution;
	float test = stroke( 0.5, uv.y, stroke_size);
	ALBEDO = vec3( test );
}