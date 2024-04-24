shader_type canvas_item;

uniform float change_velocity = 1.0; 
uniform sampler2D noise;


void vertex() {
	// Called for every vertex the material is visible on.
}


void fragment() {
	vec4 color = texture(TEXTURE, UV);
	// float noise_val = texture(noise,UV).r+sin(TIME)/PI;
	float noise_val = texture(noise,UV).r+(sin(TIME*change_velocity)*0.5)/PI-0.3;
	// aply the noise and the alpha value when
	vec4 finish_color = color-vec4(noise_val,1.0,1.0, 0.0);
	COLOR = finish_color* 1.2;
	
}

//void light() {
	// Called for every pixel for every lWight affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
