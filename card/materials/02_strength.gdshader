shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"

uniform vec2 pos = vec2(-1.035, 0.5);
uniform float amplitude = 0.144;
uniform float frequency = 5.455;

void fragment() {
	vec2 uv = UV / uv_resolution;
	uv.y = 1.0 - uv.y;
	
	float cosinus = pos.y + cos(pos.x + uv.y * frequency) * amplitude;
	
	float white_area = step(cosinus, uv.x);
	float black_area = 1.0 - white_area;
	
	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
