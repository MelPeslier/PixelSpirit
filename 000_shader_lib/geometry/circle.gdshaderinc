group_uniforms circle;
uniform float circle_radius;
uniform float circle_power = 2.0;
uniform vec2 circle_pos;

float circleSDF(vec2 _uv, vec2 _pos, float _radius, float _power){
	return length(_uv - _pos) / pow(_radius, _power);
	// The same as length
	//return sqrt( pow( abs(_uv.x - _pos.x) , _power) + pow( abs(_uv.y - _pos.y), _power) ) / pow(_radius, _power);
}