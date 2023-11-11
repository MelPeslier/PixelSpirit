shader_type spatial;

void fragment() {
	// Patricio Gonzales
//	vec3 color = vec3(0.0);
//	color += step(0.5, UV.x);
//	ALBEDO = color;
	
	// Me
	ALBEDO = step(0.5, UV.x) * vec3(1.0);
}
