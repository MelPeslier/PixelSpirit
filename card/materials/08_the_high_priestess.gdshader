shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/stroke/stroke.gdshaderinc"
#include "res://000_shader_lib/geometry/circle.gdshaderinc"

void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
//	vec2 uv = UV - 0.5;
//	uv *= uv_resolution;
//	uv += 0.5;
	uv = uv * 2.0 * uv_resolution - 1.0 * uv_resolution;

//	float geo = pow(uv.x - pos.x, 2.0) + pow(uv.y - pos.y, 2.0);
	float geo = circleSDF(uv, circle_pos, circle_radius, circle_power);

	// Pour remplir le cercle
	//ALBEDO = step(circleSDF(uv), 0.5) * white.rgb;

//	output = clamp(output, 0.0, 1.0);
//	ALBEDO = stroke(output, uv.x, stroke_size) * white.rgb;

	float white_area = stroke(geo, 0.5, stroke_width);
	float black_area = 1.0 - white_area;

	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
