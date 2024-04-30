#include "circle.gdshaderinc"

float vesicaSDF(vec2 _uv, vec2 _offset, float _radius, float _power){
	return max( circleSDF(_uv, _offset, _radius, _power),
				circleSDF(_uv, -_offset, _radius, _power));
}