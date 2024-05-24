shader_type canvas_item;

uniform vec2 uv_resolution = vec2(1.0);
uniform float rotation;
uniform float zoom;

uniform float index = 0.0;
uniform float amplitude = 0.5;
uniform float power = 10.0;

//  Function from Iñigo Quiles
//  https://www.shadertoy.com/view/MsS3Wc
vec3 hsb2rgb( in vec3 c ){
	vec3 rgb = clamp(abs(mod(c.x*6.0+vec3(0.0,4.0,2.0),6.0)-3.0)-1.0,
	0.0,1.0 );
	rgb = rgb*rgb*(3.0-2.0*rgb);
	return c.z * mix( vec3(1.0), rgb, c.y);
}

void fragment(){
	vec2 st = UV/uv_resolution;


	vec3 color = vec3(0.0);

	// Use polar coordinates instead of cartesian
	vec2 toCenter = vec2(0.5 / uv_resolution) - st;

	float _rotation = rotation * mod( rotation + TIME, TAU );
	float _zoom = zoom;

	float angle = atan(toCenter.y,toCenter.x) + _rotation;
	float radius = length(toCenter)*2.0 + zoom;

	// Map the angle (-PI to PI) to the Hue (from 0 to 1)
	// and the Saturation to the radius

	vec3 hsb_color = vec3((angle/TAU)+0.5,radius,1.0);

	color = hsb2rgb(hsb_color);

	COLOR = vec4(color,1.0);
	COLOR.a = step( length(toCenter), 0.5);
}
