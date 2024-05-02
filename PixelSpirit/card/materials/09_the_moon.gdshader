shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/geometry/circle.gdshaderinc"

group_uniforms cirle_2;
uniform float circle_2_radius = 0.85;
uniform vec2 circle_2_pos = vec2(0.125);



void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	uv = uv * 2.0 * uv_resolution - 1.0 * uv_resolution;

	float geo = circleSDF(uv, circle_pos, circle_radius, circle_power);

	// First cirlce
	float white_area = fill(geo, fill_aim);
	// Second circle
	float geo_2 = circleSDF(uv, circle_2_pos, circle_2_radius, circle_power);
	white_area -= step(geo_2, 0.5);
	//clamp for values between 0 and 1
	white_area = clamp(white_area, 0, 1);

	float black_area = 1.0 - white_area;

	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
