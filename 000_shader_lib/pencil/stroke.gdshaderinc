// *** Stroke ***
// Draw a line of size 'width', at the 'edge' coordinates,
// compared to the UV coordinates

group_uniforms stroke;
uniform float stroke_aim = 0.5;
uniform float stroke_width = 0.1;

// _edge is like a geometry, or something to draw
// _aim  or  UV aiming is for geometries based on uv that goes from 0 to 1, the 'radius', or more, where to cut the geo and show it
// _width, well, pretty obvious ?
float stroke(float _edge, float _aim, float _width){
	return step(_edge, _aim + _width * 0.5) - step(_edge, _aim - _width * 0.5);
}