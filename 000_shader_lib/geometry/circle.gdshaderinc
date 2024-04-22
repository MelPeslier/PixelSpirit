group_uniforms circle;
uniform float radius : hint_range(0.0, 10.0) = 1.779;
uniform float power = 2.0;
uniform vec2 pos = vec2(0.5);

float circleSDF(vec2 _uv, vec2 _pos, float _radius, float _power){
	//return length(_uv - _pos) * pow(_radius, _power);
	return sqrt( pow( abs(_uv.x - _pos.x) , _power) + pow( abs(_uv.y - _pos.y), _power) ) / pow(_radius, _power);
}