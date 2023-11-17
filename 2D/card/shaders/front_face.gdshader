shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture;

void fragment() {
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	
	vec4 color = texture(TEXTURE, UV);
	
	vec4 output_color = vec4( screen_color.rgb, 1.0) ;
//	if (color.r > 0.0 && color.g < 0.1 && color.b < 0.1){
//		output_color.rgb = color.rgb;
//		if (screen_color.r > 0.5){
//			output_color.rgb = vec3(0.0);
//		}else{
//			output_color.rgb = vec3(1.0);
//		}
//	}
	output_color = vec4(1.0) * step(0.3, color.r);
	output_color.rgb = step(screen_color.r, 0.6) * output_color.rgb;
	
	COLOR = output_color;
}



