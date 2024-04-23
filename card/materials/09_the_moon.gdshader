shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/geometry/stroke.gdshaderinc"
#include "res://000_shader_lib/geometry/circle.gdshaderinc"

group_uniforms cirle_2;
uniform vec2 pos_2 = vec2(0.25);
uniform float radius_2 = 0.25;
uniform float fill_it = 0.25;

float fill(float x) {
	//return 1.0 - step(size, x);
	// Same as (with size  = 0.5, for normal shapes, not modifying
	return step(x, 0.5);
}

void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	uv = uv * 2.0 * uv_resolution - 1.0 * uv_resolution;

	float geo = circleSDF(uv, pos, radius, power);

	// First cirlce
	float white_area = step(geo, fill_it);
	// Second circle
	float geo_2 = circleSDF(uv, pos_2, radius_2, power);
	white_area -= step(geo_2, 0.5);
	//clamp for values between 0 and 1
	white_area = clamp(white_area, 0, 1);

	float black_area = 1.0 - white_area;

	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
