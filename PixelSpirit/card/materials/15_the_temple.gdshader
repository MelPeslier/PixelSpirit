shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"

uniform float n = 3.0;

void fragment() {
	vec2 uv = (UV * 2.0 - 1.0 ) * uv_resolution;

	float a = atan(uv.x, uv.y) ;
	float r = TAU / n;

	float inner_tri_sdf = cos(floor(.5+a/r)*r-a)*length(uv);
	a += PI;
	float tri_sdf = cos(floor(.5+a/r)*r-a)*length(uv) ;
	float outer_tri = fill(tri_sdf, 0.25);
	float inner_tri = fill(inner_tri_sdf, 0.125);

	float output = outer_tri - inner_tri;
	output = clamp(output, 0.0, 1.0);


	ALBEDO = mix(black.rgb, white.rgb, output);
	//ALBEDO = vec3( tri_sdf );

	// By the author
	//uv *= 2.0;
	//By gonzales
	//float gonzales = max( abs(uv.x) * 0.866025 + uv.y * 0.5, -uv.y * 0.5 ) ;

	// Test by me
	//uv.y -= 0.2;
	//float test = max( abs(uv.x) * 0.9 + uv.y * 0.6, - uv.y * 0.5 );
	//uv.y = 1.0 - uv.y - 1.465;
	//float test_2 = max( abs(uv.x) * 0.9 + uv.y * 0.6, - uv.y * 0.5 );
	//
	//output = fill(test, 0.4) - fill(test_2, 0.2);
//
	//ALBEDO = vec3( output );
	//ALBEDO = mix(black.rgb, white.rgb, test);
}
