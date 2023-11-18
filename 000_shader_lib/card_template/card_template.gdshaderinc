// *** Card Template ***


// Global parameters ***
global uniform vec4 black;
global uniform vec4 white;

// Local parameters ***
uniform float uv_resolution : hint_range(0.1, 25.0) = 1.0;


// Functions ***

// Zoom + y = 0 at bottom; y = 1 at top;
vec2 new_uv(vec2 uv){
	uv = uv / uv_resolution;
	uv.y = 1.0 - uv.y;
	return uv;
}