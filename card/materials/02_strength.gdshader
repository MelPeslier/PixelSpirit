shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"

uniform vec2 pos = vec2(-1.035, 0.5);
uniform float amplitude : hint_range(0.0, 5.0) = 0.144;
uniform float frequency : hint_range(0.0, 10.0) = 5.455;

void fragment() {
	vec2 uv = new_uv(UV);
	
	float cosinus = pos.y + cos(pos.x + uv.y * frequency) * amplitude;
	
	float white_area = step(cosinus, uv.x);
	float black_area = 1.0 - white_area;
	
	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
