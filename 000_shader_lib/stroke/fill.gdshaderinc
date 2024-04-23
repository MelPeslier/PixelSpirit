float fill(float x) {
	//return 1.0 - step(size, x);
	// Same as (with size  = 0.5, for normal shapes, not modifying
	return step(x, 0.5);
}