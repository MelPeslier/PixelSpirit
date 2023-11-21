shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"

void fragment() {
	vec2 uv = UV / uv_resolution;
	
	float white_area = step(0.5, uv.x);
	float black_area = 1.0 - white_area;
	
	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
