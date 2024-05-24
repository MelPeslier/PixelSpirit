shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/stroke.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/geometry/polySDF.gdshaderinc"


void fragment() {
	vec2 uv = (UV * 2.0 - 1.0) * uv_resolution;

	float circ = length(uv);
	uv.y -= 0.4;
	float tri = polySDF(3, uv);

	float output = clamp(stroke(circ, 0.3, 0.075) - fill(tri, 0.22), 0.0, 1.0) + fill(tri, 0.18);


	ALBEDO = mix(black.rgb, white.rgb, output) ;
}
