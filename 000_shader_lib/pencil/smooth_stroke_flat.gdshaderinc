group_uniforms smooth_stroke_flat;
uniform vec2 ssf_in_aim_smooth = vec2(0.3, 0.1);
uniform vec2 ssf_out_aim_smooth = vec2(0.6, 0.1);
// smoothstep( inner far to geo, inner smooth) * smoothstep( outer far from geo, outer smooth )
float smoothStroke(float _geo, vec2 _in_aim_smooth , vec2 _out_aim_smooth) {
	return abs(smoothstep( _in_aim_smooth.x, _in_aim_smooth.x + _in_aim_smooth.y, _geo)
			* smoothstep(_out_aim_smooth.x, _out_aim_smooth.x - _out_aim_smooth.y , _geo));
}