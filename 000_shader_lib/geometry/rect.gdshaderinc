group_uniforms rect;
uniform vec2 rect_pos = vec2(0);
uniform vec2 rect_size = vec2(1);


// i noticed that this first edge, is, when using this type of geo, THE cone cut at a certain range form midle
// Like it's smoothing from 0 to 1, form center to edges depending of maths, then cutting it is like choosing a radius.
// It's the radius from center, based on 'uv'

float rectSDF(vec2 _uv, vec2 _pos, vec2 _size){
	return max( ( abs(_uv.x - _pos.x) /_size.x ),
				( abs(_uv.y - _pos.y) /_size.y ) );
}

float reverseRectSDF(vec2 _uv, vec2 _pos, vec2 _size){
	return min( ( abs(_uv.x - _pos.x) /_size.x ),
				( abs(_uv.y - _pos.y) /_size.y ) );
}

float crossSDF(vec2 _uv, vec2 _pos, vec2 _size){
	return min( rectSDF(_uv, _pos, _size.xy),
				rectSDF(_uv, _pos, _size.yx) );
}