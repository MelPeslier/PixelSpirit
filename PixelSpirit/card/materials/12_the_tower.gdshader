shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
// Pencil
#include "res://000_shader_lib/pencil/stroke.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/pencil/flip.gdshaderinc"

// Geometry
#include "res://000_shader_lib/geometry/rect.gdshaderinc"



void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	uv = uv * 2.0 * uv_resolution - uv_resolution;

	float rect = rectSDF( uv, rect_pos, rect_size);
	rect = fill( rect , fill_aim);
	float diag = stroke( (uv.x + uv.y) * 0.5, stroke_aim, stroke_width);
	float output = flip(rect, diag);

	//output = clamp(output, 0.0, 1.0);
	ALBEDO = output * white.rgb + (1.0 - output) * black.rgb;

}
