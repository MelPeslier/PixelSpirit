
float polySDF(float _n, vec2 _uv){
	float a = atan(_uv.x, _uv.y);
	float r = TAU/_n;
	return cos(floor(.5+a/r)*r-a)*length(_uv);
}