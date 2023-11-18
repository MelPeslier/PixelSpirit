// *** Stroke ***
// Draw a line of size 'width', at the 'edge' coordinates,
// compared to the UV coordinates

float stroke(float edge, float uv_pos, float width){
	float stroke = step(edge, uv_pos + width) - step(edge, uv_pos - width);
	return stroke;
}