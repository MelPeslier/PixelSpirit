shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/stroke.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/geometry/polySDF.gdshaderinc"

float ndot(vec2 a, vec2 b ) { return a.x*b.x - a.y*b.y; }
float sdRhombus( in vec2 p, in vec2 b ) {
	p = abs(p);
	float h = clamp( ndot(b-2.0*p,b)/dot(b,b), -1.0, 1.0 );
	float d = length( p-0.5*b*vec2(1.0-h,1.0+h) );
	return d * sign( p.x*b.y + p.y*b.x - b.x*b.y );
}


float triSDF(vec2 st){
	st = (st*2.0-1.0)*2.0;
	return max(abs(st.x) * 0.8660255 + st.y * 0.5, -st.y * 0.5);
}

float rhombSDF(vec2 st) {
	return max(triSDF(st), triSDF(vec2(st.x, 1.0 - st.y)));
}


void fragment() {
	vec2 uv = (UV * 2.0 - 1.0) * uv_resolution;

	float rhombus = sdRhombus(uv*vec2(1.0,0.5), vec2(0.25));
	float rhombus2 = rhombSDF(UV);

	float output = clamp( 
		step(rhombus2, 0.425) + (stroke(rhombus2, 0.5, 0.05)) + + (stroke(rhombus2, 0.6, 0.03))
	,0.0, 1.0);


	//ALBEDO = vec3(step(rhombus, 0.0));
	ALBEDO = mix(black.rgb, white.rgb, output) ;
}
