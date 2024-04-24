shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
//#include "res://000_shader_lib/pencil/stroke.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/geometry/rect.gdshaderinc"

uniform float test_power = 2.0;
uniform float test_aim = 0.5;
uniform float test_width = 0.2;
// in_out of geometry
uniform vec2 test_smooth = vec2(0.1);

float stroke(float _edge, float _aim, float _width) {
	return step(_edge, _aim + _width * 0.5) - step(_edge, _aim - _width * 0.5);
}

// smoothstep( inner far to geo, inner close to geo) * smoothstep( outer far from geo, outer close to geo )
float smoothStroke(float _geo, float _size, float _width, vec2 _smooth) {
	return abs(smoothstep( _size, _size - _smooth.x, _geo) * smoothstep(_size+0.1, _size - _smooth.y , _geo));
}

void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	uv = uv * 2.0 * uv_resolution - uv_resolution;
	// To tests
	float d = length( abs(uv)-.3 );

	float output = rectSDF( uv, rect_pos, rect_size);
	output = 0.5-uv.x;
	//output = abs(uv.x) + abs(uv.y);
	//output = abs(uv.x) * abs(uv.y);
	//output = abs(uv.x) - abs(uv.y);
	//output = pow(abs(uv.x) + abs(uv.y), test_power);
	//output = pow(abs(uv.x) - abs(uv.y), test_power);
	//output = stroke(output, test_aim, test_width);
	output = smoothStroke(output, test_aim, test_width, test_smooth);
	//output = clamp(output, 0.0, 1.0);
	ALBEDO = output * white.rgb + (1.0 - output) * black.rgb;

}
