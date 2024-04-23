// *** Stroke ***
// Draw a line of size 'width', at the 'edge' coordinates,
// compared to the UV coordinates

group_uniforms stroke;
uniform float stroke_width;


// _edge is like a geometry, or something to draw
// _uv_aim is for geometries based on uv that goes from 0 to 1, the 'radius'
// _width, well, pretty obvious ?
float stroke(float _edge, float _uv_aim, float _width){
	float stroke = step(_edge, _uv_aim + _width * 0.5) - step(_edge, _uv_aim - _width * 0.5);
	return stroke;
}