shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/stroke.gdshaderinc"


void fragment() {
	vec2 uv = UV / uv_resolution;

	float geo = 0.5 + (uv.x - uv.y) * 0.5;

	float white_area = stroke(geo, uv.x, stroke_width);

	float black_area = 1.0 - white_area;

	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
