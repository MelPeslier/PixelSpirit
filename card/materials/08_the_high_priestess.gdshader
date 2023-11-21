shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/geometry/stroke.gdshaderinc"

uniform float stroke_size = 0.015;
uniform float radius : hint_range(0.0, 10.0) = 1.0;
uniform float power = 2.0;
uniform vec2 pos = vec2(0.5); 

float circleSDF(vec2 _uv){
//	return length(_uv - pos) * pow(radius, 2.0);
return sqrt( pow( abs(_uv.x - pos.x) , power) + pow( abs(_uv.y - pos.y), power) ) * pow(radius, power);
}

void fragment() {
	vec2 uv = UV / uv_resolution;
	float output = 0.0;
	float line = uv.x - uv.y;
//	output += line;
	
	float geo = pow(uv.x - pos.x, 2.0) + pow(uv.y - pos.y, 2.0);
	output += geo;
	
//	ALBEDO = stroke(circleSDF(uv), 0.5, stroke_size) * white.rgb;
	ALBEDO = step(circleSDF(uv), 0.5) * black.rgb;
	
//	output = clamp(output, 0.0, 1.0);
//	ALBEDO = stroke(output, uv.x, stroke_size) * white.rgb;
	
//	float white_area = stroke(geo, uv.x, stroke_size);
//	float black_area = 1.0 - white_area;
//
//	ALBEDO = black_area * black.rgb + white_area * white.rgb;
}
