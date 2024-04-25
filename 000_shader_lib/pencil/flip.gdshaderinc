float flip(float _geo_1, float _geo_2) {
	return mix(_geo_1, 1.0 - _geo_1, _geo_2);
	// Lerp ... = mix()
	//return _geo_1 + _geo_2 * ((1.0-_geo_1) - _geo_1);
	//return _geo_1 + _geo_2 * (1.0 - _geo_1) + _geo_2 * -_geo_1;
	// My method
	//return _geo_1 * step( _geo_2, 0.5) + _geo_2 * step( _geo_1, 0.5);
}