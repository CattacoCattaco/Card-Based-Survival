shader_type canvas_item;

uniform vec4 replaced_color;
uniform vec4 new_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	
	if(input_color == replaced_color)
	{
		COLOR = new_color;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
