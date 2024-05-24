shader_type canvas_item;
uniform float N : hint_range(0.0, 15.0, 1.0) = 3.0;

uniform float aim = 0.5;
uniform float rotation = 0;
uniform float rotation_speed = 0;

float plot (float y, float pct, float w){
  return  smoothstep( pct-w, pct, y) -
          smoothstep( pct, pct+w, y);
}

float polySDF(float _n, vec2 _uv){
	float a = atan(_uv.x, _uv.y);
	float r = TAU/_n;
	return cos(floor(.5+a/r)*r-a)*length(_uv);
}

void fragment() {
	vec2 uv = UV * 2. - 1.;
	float _rotation = mod( rotation + rotation_speed * TIME, TAU);
	vec2 vr = abs(uv.xy);
	// Square SDF
	float s = max(vr.x, vr.y);

	// Cross SDF
	//s = min(r.x, r.y);

	// Square Smooth Borders
	// uv - x : on déplace le centre du cercle
	// abs( uv ) : on le répètre de tous les côtés
	// max( pour arrondir les bords )
	vec2 pb = abs( uv ) - 0.35;
	s = length( vec2(max(pb.x, 0.), max(pb.y, 0.) ) ) ;

	// coordonnées polaires -> cercle et rotation
	float a = atan(uv.x,uv.y) + _rotation;
	float r = TAU/N;


	s = cos(floor(.5+a/r)*r-a)*length(uv);

	// Fill
	float fill = step(aim, s);

	// Stroke
	float stroke = step(aim - 0.05, s) * step(s, aim + 0.05);

	// Smooth Stroke
	float smooth_stroke = smoothstep(0.2, 0.3, s) * smoothstep(0.5, 0.4, s);

	COLOR.rgb = vec3(s);
	//COLOR.rgb = vec3(fill);
	//COLOR.rgb = vec3(stroke);
	//COLOR.rgb = vec3(smooth_stroke);
	//COLOR.rgb = mix(COLOR.r, plot(vr.y, vr.x, 0.05), a);
	COLOR.a = 1.0;
}

