shader_type canvas_item;

void fragment() {
	COLOR.rgb = step(0.5, UV.x) * vec3(1.0);
}
