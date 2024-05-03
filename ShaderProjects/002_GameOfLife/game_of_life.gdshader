shader_type canvas_item;

group_uniforms lit;
uniform vec3 lit_color : source_color = vec3(1.0);
uniform float lit_power : hint_range(0.1, 50.0) = 2.0;
uniform float lit_aim : hint_range(0.01, 1.0) = 0.45;
//uniform sampler2D litTexture; // Texture for binary 1

group_uniforms unlit;
uniform vec3 unlit_color : source_color = vec3(0.0);
uniform float unlit_power : hint_range(0.1, 50.0) = 2.0;
uniform float unlit_aim : hint_range(0.01, 1.0) =0.45;
//uniform sampler2D unlitTexture; // Texture for binary 0

group_uniforms bacdkground;
uniform vec3 background_color : source_color = vec3(0.5);

group_uniforms grid;
uniform int gridWidth;      // Number of cells horizontally and vertically
uniform vec2 scale = vec2(1.0);
const int cellSize = 8;    // Cell size in pixels
const float fadeDistance = 32.0; // Distance from border where fading starts

group_uniforms BinaryData;
uniform sampler2D binaryDataTexture; // 2D texture for binary data
// # TODO : Selon les données retournées, faire en sorte que le cercle se déplace un peu vers le vecteur ou il y a le plus de cases voisines

float circleSquaredSDF(vec2 _uv, float _power){
	return sqrt( pow( abs(_uv.x) , _power) + pow( abs(_uv.y), _power) ) / pow(1.0, _power);
}

float fill(float _edge, float _aim){
	return step(_edge, _aim);
}

void fragment() {
	// Donnée pour le  coupute shader ?
	vec2 totalGridSize = vec2(float(gridWidth) * float(cellSize));

	vec2 _scale = vec2( min(scale.x, 1.0), min(scale.y, 1.0) );

	// On multiplie l'UV par le nombre de cellules que l'on veut, puis on le scale par rapport au ratio de l'image si elle n'est pas carrée
	vec2 scaledUV = UV * _scale * float(gridWidth);

	// Arondit l'index à l'entier près : tous les pixels dans cellIndex seront de la même couleur,
	// on pourrra donc renseigner à tel et tel pixel dans quelle case il est, donc quoi afficher
	ivec2 cellIndex = ivec2(floor(scaledUV));

	// On répète notre motif entre 0 et 1 originel
	vec2 cellUV = fract(scaledUV);

	// # TODO : remplacer ce bool par un step

	// On dit que tous ces pixels sont dans la cellule ou pas
	bool isInsideCell = all(greaterThanEqual(cellUV, vec2(0.0))) && all(lessThan(cellUV, vec2(1.0)));

	// On donne à chaque case une valeur différente entre 0 et la taille de la grille - 1
	vec2 binaryDataUV = vec2(
		float(cellIndex.x) / float(gridWidth - 1),
		float(cellIndex.y) / float(gridWidth - 1)
	);

	// On lit la valeur de la texture, qui sera entre 0 et 1
	float binaryValue = texture(binaryDataTexture, binaryDataUV).r;
	// Les valeurs supérieurs à 0.5 seront mises à 1 et inversement à 0
	float isAlive = step(0.5, binaryValue);


	float unlit_geo = fill( circleSquaredSDF(cellUV - vec2(0.5), unlit_power), unlit_aim );
	float lit_geo = fill( circleSquaredSDF(cellUV - vec2(0.5), lit_power), lit_aim);
	//float lit_geo = circleSquaredSDF(cellUV, lit_power);

	float all_pct = mix(unlit_geo, lit_geo, isAlive) ;
	float bg_pct = 1.0 - all_pct;

	vec3 all_colors = mix(unlit_color, lit_color, isAlive);

	COLOR.rgb = all_pct * all_colors + bg_pct * background_color;

	// # TODO differently
	// Calcul la distance avec les bords pour faire un effet de fondu
	//vec2 distToBorder = min(scaledUV, float(gridWidth) * _scale - scaledUV) * float(cellSize);
	//float distanceToBorder = min(distToBorder.x, distToBorder.y);
	//float alphaFactor = log(distanceToBorder) / log(fadeDistance);
	//COLOR.a *= alphaFactor;

	// Fade borders
	//vec2 distanceToBorder = min(scaledUV, float(gridWidth) * _scale - scaledUV) * float(cellSize) ;
	//float dist = min(distanceToBorder.x, distanceToBorder.y);
	//float alphaFactor = dist / float(gridWidth) / float(cellSize) * 20.0;
	//COLOR.a *= alphaFactor;


	 //Nice to reveal 1 by one to see the process :
	//vec2 pct = fract( scaledUV );
	//COLOR = vec4(0.0, pct, 1.0);
	//COLOR = vec4(0.0, scaledUV, 1.0);
	//COLOR = vec4(float(cellIndex.x), float(cellIndex.y), 0.0, 1);
	//COLOR.rgb = lit_color * cellUV.x * cellUV.y;
	//COLOR = vec4(binaryDataUV, 0.0, 1);
	//COLOR.rgb = vec3(isAlive);
	//COLOR.rgb = mix(unlit_color, lit_color, isAlive);

}