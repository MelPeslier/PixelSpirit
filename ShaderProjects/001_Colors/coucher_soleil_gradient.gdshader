shader_type canvas_item;

uniform vec2 uv_resolution = vec2(1.0);
uniform vec3 sun_high : source_color;
uniform vec3 sun_low : source_color;
uniform vec3 sun_gone : source_color;

float easeInQuad( float x ) {
	return x * x;
}

float easeOutSine(float x){
	return sin((x * PI) / 2.0);
}

// st must be the new uv the shpae is drawned on !
float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

void fragment() {
	vec2 uv = UV / uv_resolution;
	uv.y = 1.0 - uv.y;

	vec3 color = vec3(0.0);
	// Transition lineaire
	vec3 pct = vec3( uv.x ) ;

	pct.r = smoothstep(0.0,1.0, uv.x) * uv.x;
	pct.g = easeOutSine(uv.x);
	pct.b = easeInQuad(uv.x);

	color = mix(sun_high, sun_gone, pct);

	// Good Result
	//vec3 colA = vec3(0.0);
	//vec3 colB = vec3(1.0);
	//pct.r = smoothstep(0.0,1.0, uv.x) - uv.x * 0.2;
	//pct.g = sqrt(uv.x) * uv.x  - uv.x * 0.25;
	//pct.b = easeInQuad(uv.x * 0.5) + 0.15;
	//color = mix(colA, colB, pct);


	// Plot transition lines for each channel
	color = mix(color,vec3(1.0,0.0,0.0),plot(uv,pct.r));
	color = mix(color,vec3(0.0,1.0,0.0),plot(uv,pct.g));
	color = mix(color,vec3(0.0,0.0,1.0),plot(uv,pct.b));

	COLOR = vec4(color, 1.0);
}

