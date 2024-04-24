shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/stroke.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/geometry/rect.gdshaderinc"

group_uniforms card_parameters;
// Using the aim will give a similar result than using rect sizes
//uniform float stroke_2_aim;
//uniform float stroke_2_width;
//uniform float inner_stroke_1_aim;
//uniform float inner_stroke_1_width;
//uniform float inner_stroke_2_aim;
//uniform float inner_stroke_2_width;
//uniform float inner_stroke_3_aim;
//uniform float inner_stroke_3_width;
//uniform float inner_stroke_4_aim;
//uniform float inner_stroke_4_width;
//uniform float inner_stroke_5_aim;
//uniform float inner_stroke_5_width;

uniform vec2 uv_test;

void fragment() {
	// UV ***
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	uv = uv * 2.0 * uv_resolution - uv_resolution;

	// Method 1 ***
	// Stroke outlines white + fill inside white + stroke inline black ( remove from white )
	//float outer = stroke( rectSDF(uv, rect_pos, rect_size), stroke_aim, stroke_width);
	//outer += stroke( rectSDF(uv, rect_pos, rect_size), stroke_2_aim, stroke_2_width);
	//float inner = fill( rectSDF(uv, rect_pos, rect_size), fill_aim);
	//float inner_1 = inner * stroke(reverseRectSDF(uv, rect_pos, rect_size), inner_stroke_1_aim, inner_stroke_1_width);
	//float inner_2 = inner * stroke(reverseRectSDF(uv, rect_pos, rect_size), inner_stroke_2_aim, inner_stroke_2_width);
	//float inner_3 = inner * stroke(reverseRectSDF(uv, rect_pos, rect_size), inner_stroke_3_aim, inner_stroke_3_width);
	//float inner_4 = inner * stroke(reverseRectSDF(uv, rect_pos, rect_size), inner_stroke_4_aim, inner_stroke_4_width);
	//float inner_5 = inner * stroke(reverseRectSDF(uv, rect_pos, rect_size), inner_stroke_5_aim, inner_stroke_5_width);
//
	//float white_area = outer + inner_1 + inner_2 + inner_3 + inner_4 + inner_5;
	//white_area = clamp(white_area, 0, 1);
//
	//float black_area = 1.0 - white_area;
//
	//ALBEDO = white_area * white.rgb + black_area * black.rgb;

	// Method 2 ***
	// using the card logic and the cross function
	float rect = rectSDF(uv, rect_pos, rect_size);
	float output = fill(rect, 0.5);
	float croix = crossSDF(uv, rect_pos, vec2(0.25, 1.0));
	output *= step(0.5, fract(croix * 5.0));
	//output = step(0.5, fract( rectSDF(uv, rect_pos, rect_size) * 4.0 ) );
	output *= step(1.0, croix);
	output += fill( croix, 0.5 );
	output += stroke( rect, 0.65, 0.05);
	output += stroke( rect, 0.75, 0.025);

	// for any overlapses
	output = clamp(output, 0.0, 1.0);

	ALBEDO = output * white.rgb + (1.0 - output) * black.rgb;

	// Good Looking
	//Test using the inverse squares
	//float rect_2 = rectSDF(uv, rect_pos, rect_size);
	//float output_2 = fill( rect_2, 0.5);
	//float croix_2 = reverseRectSDF( uv * uv_test , rect_pos, vec2(0.5) );
	//output_2 *= step(0.5, fract(croix_2 * 10.0));
	//output_2 *= stroke( 0.5,rect_2 * croix_2 *20.0, 0.5);
//
	//ALBEDO = vec3( output_2) ;


}

































