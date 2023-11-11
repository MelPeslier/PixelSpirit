shader_type spatial;

uniform float div : hint_range(0, 3.0) = 0.5;

void fragment() {
	vec2 uv = vec2( UV.x, 1.0 - UV.y );
	ALBEDO = step( 0.5, (uv.x + uv.y) * div ) * vec3(1.0);
}
