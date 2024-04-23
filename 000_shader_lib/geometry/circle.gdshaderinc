group_uniforms circle;
uniform vec2 circle_pos;
uniform float circle_power = 2.0;
uniform float circle_radius;

float circleSDF(vec2 _uv, vec2 _pos, float _radius, float _power){
	// Here power is useless, it doesn't affect the form
	//return length(_uv - _pos) / pow(_radius, _power);
	// The same as length for a power of 2, else, the more the power, the more the square
	return sqrt( pow( abs(_uv.x - _pos.x) , _power) + pow( abs(_uv.y - _pos.y), _power) ) / pow(_radius, _power);
}