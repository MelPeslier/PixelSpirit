shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/stroke.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/geometry/rect.gdshaderinc"


void fragment() {
	// UV ***
	vec2 uv = UV;
	// Reverse uv.y 0 at bottom 1 at top
	uv.y = 1.0 - uv.y;
	// Center uv + scale it
	uv = uv * 2.0 * uv_resolution - uv_resolution;

	// GEO ***
	float geo = stroke(rectSDF(uv, rect_pos, rect_size), stroke_aim, stroke_width);
	float geo_2 = fill(rectSDF(uv, rect_pos, rect_size), fill_aim);
	float white_area = geo + geo_2;
	float black_area = 1.0 - white_area;
	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}