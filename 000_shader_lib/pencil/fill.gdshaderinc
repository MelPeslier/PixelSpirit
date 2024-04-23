// edge is the geometry to draw, so a lineusing uv or triangles etc...
// you know for _aim : if your geo is going ffrom 0 to 1, then choose where to cut
group_uniforms fill;
uniform float fill_aim = 0.5;

float fill(float _edge, float _aim) {
	//return 1.0 - step(size, x);
	// Same as (with size  = 0.5, for normal shapes, not modifying
	return step(_edge, _aim);
}