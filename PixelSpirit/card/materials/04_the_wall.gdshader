shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/stroke.gdshaderinc"

uniform float width: hint_range(-1.0, 1.0) = 0.15;

void fragment() {
	vec2 uv = UV / uv_resolution;
	ALBEDO = black.rgb;

	float pos = 0.5;
	float uv_pos = UV.x;

	float ligne = stroke(pos, uv_pos, width);
//	float ligne = step(0.5, UV.x);
//	ALBEDO += vec3(ligne);
	ALBEDO = (1.0 - ligne) * black.rgb + ligne * white.rgb;
}
