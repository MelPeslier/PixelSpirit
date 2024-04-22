shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/geometry/stroke.gdshaderinc"

group_uniforms temperance;
uniform vec2 pos = vec2(-1.035, 0.5);
uniform float amplitude = 0.144;
uniform float frequency = 5.455;
uniform float interval = 0.15;

void fragment() {
	vec2 uv = UV / uv_resolution;
	uv.x = 1.0 - uv.x;

	float wave = pos.y + cos(pos.x + uv.y * frequency) * amplitude;

	float white_area = stroke(interval + wave,uv.x, stroke_size)
		+ stroke(wave, uv.x, stroke_size)
		+ stroke(wave - interval, uv.x, stroke_size)
	;

	white_area = clamp(white_area, 0.0, 1.0);
	float black_area = 1.0 - white_area;

	vec3 card = black_area * black.rgb + white_area * white.rgb;
	ALBEDO = card;
}