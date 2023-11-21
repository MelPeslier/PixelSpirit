shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/geometry/stroke.gdshaderinc"

uniform float stroke_size = 0.07;

void fragment() {
	vec2 uv = UV / uv_resolution;
	
	float geo1 = 0.5 + (uv.x - uv.y) * 0.5;
	
//	uv.y = 1.0 - uv.y;
//	float geo2 = 0.5 + (uv.x - uv.y) * 0.5;
	float geo2 = (uv.x + uv.y) * 0.5;
	
	float white_area = stroke(geo1, uv.x, stroke_size) + stroke(geo2, uv.x, stroke_size);
	white_area = clamp(white_area, 0.0, 1.0);
	float black_area = 1.0 - white_area;

	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
