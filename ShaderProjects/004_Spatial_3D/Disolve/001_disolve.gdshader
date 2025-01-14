shader_type spatial;
render_mode cull_disabled;

uniform float threshold : hint_range(0.0, 1.0) = 0.5;
uniform float width: hint_range(0.0, 1.0) = 0.2;

uniform vec3 direction = vec3(0.0, 1.0, 0.0);

uniform vec3 normal_color : source_color;
uniform vec3 disolve_color : source_color;

uniform sampler2D disolve_texture : hint_default_black;

varying vec4 world_position;

void vertex() {
	world_position = MODEL_MATRIX * vec4(VERTEX, 1.0);
}

void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;

	float pct = step(uv.y, threshold);

	float mask = texture(disolve_texture, uv).r;

	float edge = step(uv.y, threshold + width);

	ALBEDO = edge * disolve_color + (1.0 - edge) * normal_color;
	//ALPHA = pct;
}
