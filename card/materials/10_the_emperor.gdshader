shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/stroke/stroke.gdshaderinc"

group_uniforms square;
uniform float c;
uniform vec2 rect_size;
uniform vec2 rect_pos;
// i noticed that this first edge, is, when using this type of geo, THE cone cut at a certain range form midle
// Like it's smoothing from 0 to 1, form center to edges depending of maths, then cutting it is like choosing a radius.
// It's the radius from center, based on 'uv'
uniform float stroke_aim = 0.5;

float rectSDF(vec2 _uv, vec2 _pos, vec2 s){
	return min( ( abs(_uv.x - _pos.x) /s.x ),
				( abs(_uv.y - _pos.y) /s.y ) );
}

void fragment() {
	vec2 uv = UV;
	// Reverse uv.y 0 at bottom 1 at top
	uv.y = 1.0 - uv.y;
	// Center uv + scale it
	uv = uv * 2.0 * uv_resolution - uv_resolution;
	vec2 bl = step(vec2(0.1),uv);       // bottom-left
	vec2 tr = step(vec2(0.1),1.0-uv);   // top-right
	vec3 test = vec3( bl.x * bl.y * tr.x * tr.y) ;

	float geo = rectSDF(uv, rect_pos, rect_size);
	//ALBEDO = vec3( test );
	ALBEDO = vec3( stroke(stroke_aim, geo, stroke_width ) ) * abs(uv.x) * abs(uv.y);
}