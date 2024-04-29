shader_type spatial;

#include "res://000_shader_lib/card_template/card_template.gdshaderinc"
#include "res://000_shader_lib/pencil/flip.gdshaderinc"
#include "res://000_shader_lib/pencil/fill.gdshaderinc"
#include "res://000_shader_lib/geometry/circle.gdshaderinc"


// fonctions à faire
// inclusion ( dessine A si il est inclu dans B, donc que pour tout les points de A, A = B)
// réunion (A OU B )
// intersection ( A ET B )
// complémentaire , l'inverse ?( toutes les parties de l'ensemble A qui n'appartiennet pas à B)
	// avec l'uv la complémentaire ?
// différence, A - B (ensemble de A qui n'appartient pas à B)
// différence symétrique, A DELTA B (ensemble des éléments qui appartiennent à 1 seul des 2 ensembles


void fragment() {
	vec2 uv = UV;
	uv.y = 1.0 - uv.y;
	uv = uv * uv_resolution * 2.0 - uv_resolution;

	float circle_left = fill( circleSDF(uv, -circle_pos, circle_radius, circle_power), fill_aim);
	float circle_right = fill( circleSDF(uv, circle_pos, circle_radius, circle_power), fill_aim);
	float output = circle_left + circle_right;
	// step(x, y) : entre 2 geometrie :
	// resulte à la partie de y non incluse dans la partie de x exclue de la forme
	// cependant tout le reste de l'uv resultera de la meme valeur
	//output = step(circle_right, circle_left);

	// step( 1.0 - x, y) entre 2 géométries résulte en :
	// les deux formes sont dessinées, effecttue une sorte de de clamp(x+y, 0, 1)
	//output = step( 1.0 - circle_right, circle_left);

	//step( v - x, y) où v > 1.0
	// le résultat est l'intersection des 2 formes
	//output = step( 1.1 - circle_right, circle_left);

	// step(x + v, y) où 0.0 < v <= 1.0
	// résulte en y coupé par x
	//output = step( circle_right + 1.0, circle_left);

	// Second methods, using clamp and logical operations
	float A = circle_left;
	float B = circle_right;
	// Différence
	//output = clamp(A - B, 0, 1);
	//output = clamp(B - A, 0, 1);
	// Différence symétrique
	//output = clamp(A+B, 0.0, 1.0) - A * B;
	// Intersection
	//output = A*B;
	// Réunion
	//output = clamp(A+B, 0,1);
	//output = circle_left - circle_right;
	// mix
	//output = min(A,B);

	// Card by me :
	vec2 uv2 = UV / uv_resolution;
	uv2.x = 1.0 - uv2.x;
	float cut = step(0.5, (uv2.x + uv2.y) * 0.5);
	float center = A * B;
	// By him : For the center
	A = circleSDF(uv, -circle_pos, circle_radius, circle_power);
	B = circleSDF(uv, circle_pos, circle_radius, circle_power);
	center = fill(max(A, B), 0.5);
	// Using min of geometriesonce they are filled work too :
	center = min(circle_left, circle_right);
	output = flip(center, cut);
	//output = max(A,B);

	ALBEDO = output * white.rgb + (1.0 - output) * black.rgb;
}
