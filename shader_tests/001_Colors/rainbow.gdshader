shader_type canvas_item;

uniform float uv_resolution = 1.0;

uniform vec3 red = vec3(6.325, -6.72, 1.43);
uniform vec3 green;
uniform vec3 blue;


uniform vec3 start_color : source_color;
uniform vec3 end_color : source_color;

float parabole(float a, float b, float c, float x){
	return a * (x * x) + b * x + c ;
}
float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}
float stroke(float _edge, float _aim, float _width){
	return step(_edge, _aim + _width * 0.5) - step(_edge, _aim - _width * 0.5);
}

void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	//uv = uv * 2.0 * uv_resolution - uv_resolution;

	vec3 color = vec3(0.0);
	vec3 pct = vec3( uv.x ) ;

	pct.r = parabole(red.x, red.y, red.z, uv.x);
	pct.g = parabole(green.x, green.y, green.z, uv.x);
	pct.b = uv.x * uv.x;

	color = mix(start_color, end_color, pct);

	// Plot transition lines for each channel
	//color = mix(color,vec3(1.0,0.0,0.0),plot(uv,pct.r));
	//color = mix(color,vec3(0.0,1.0,0.0),plot(uv,pct.g));
	//color = mix(color,vec3(0.0,0.0,1.0),plot(uv,pct.b));

	COLOR.rgb = color ;
	COLOR.a = 1.0;
}

