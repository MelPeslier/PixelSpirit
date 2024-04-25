shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/stroke.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/geometry/rect.gdshaderinc"


void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	uv = uv * 2.0 * uv_resolution - uv_resolution;
	// To tests
	float d = length( abs(uv)-.3 );

	float output = rectSDF( uv, rect_pos, rect_size);
	output = length( max(abs(uv)-.3,0.) );
	//output = 0.5-uv.x;
	//output = abs(uv.x) + abs(uv.y);
	//output = abs(uv.x) * abs(uv.y);
	//output = abs(uv.x) - abs(uv.y);
	//output = pow(abs(uv.x) + abs(uv.y), test_power);
	//output = pow(abs(uv.x) - abs(uv.y), test_power);
	//output = stroke(output, test_aim, test_width);
	output = smoothStroke(output, in_aim_smooth, out_aim_smooth);
	//output = clamp(output, 0.0, 1.0);
	ALBEDO = output * white.rgb + (1.0 - output) * black.rgb;

}
