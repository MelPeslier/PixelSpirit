shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/stroke.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/pencil/flip.gdshaderinc"
#include "res://000_shader_lib/geometry/circle.gdshaderinc"

void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	uv = uv * uv_resolution * 2.0 - uv_resolution;

	float circle_left = circleSDF( uv, circle_pos, circle_radius, circle_power);
	circle_left = stroke(circle_left, stroke_aim, stroke_width);
	float circle_right = fill(circleSDF(uv, vec2(0.125, 0.0), circle_radius, circle_power), fill_aim);
	float output = flip( circle_left, circle_right);


	ALBEDO = output * white.rgb + (1.0 - output) * black.rgb;
}