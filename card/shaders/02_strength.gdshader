shader_type spatial;

uniform float u_resolution : hint_range(0.1, 25.0) = 1.0;
uniform float pos_y : hint_range(0.0, 5.0) = 0.5;
uniform float pos_x : hint_range(-5.0, 5.0) = -1.035;
uniform float amplitude : hint_range(0.0, 5.0) = 0.144;
uniform float frequency : hint_range(0.0, 10.0) = 5.455;

void fragment() {
	vec2 uv = UV / u_resolution;
	uv.y = 1.0 - uv.y;
	
	float cosinus =  pos_y + cos(pos_x + uv.y * frequency) * amplitude;
	
	ALBEDO = step(cosinus, uv.x) * vec3(1.0);
}
