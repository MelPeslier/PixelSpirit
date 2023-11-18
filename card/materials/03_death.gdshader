shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"

uniform float div : hint_range(0, 3.0) = 0.5;

void fragment() {
	vec2 uv = new_uv(UV);
	
	float white_area = step(0.5, (uv.x + uv.y) * 0.5);
	float black_area = 1.0 - white_area;
	
	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
