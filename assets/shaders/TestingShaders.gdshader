shader_type canvas_item;

uniform vec2 blur_strong = vec2(0.1, 0.1);
uniform float change_velocity = 1.0; 
uniform sampler2D noise;


void vertex() {
	// Called for every vertex the material is visible on.
}


void fragment() {
	vec2 blur_amount = blur_strong / vec2(10.0,10.0) * vec2(
		sin(TIME*change_velocity+500.0)/PI + 1.3* sin(TIME*change_velocity-150.0)/PI,
		cos(TIME*change_velocity-200.0)/PI + 1.5* cos(TIME*change_velocity+120.0)/PI 
		);
	vec4 color = texture(TEXTURE, UV);
	vec4 color_up = texture(TEXTURE, UV + vec2(0.0, blur_amount.y));
	vec4 color_down = texture(TEXTURE, UV + vec2(0.0, -blur_amount.y));
	vec4 color_left = texture(TEXTURE, UV + vec2(-blur_amount.x, 0.0));
	vec4 color_right = texture(TEXTURE, UV + vec2(blur_amount.x, 0.0));
	// you can modify the weights
	vec4 blur_color2 = color_up *0.17 + 
					color_down *0.18 + 
					color_left *0.17 + 
					color_right*0.18 +
					color      *0.3;
	vec4 blur_color1 =( color_up + color_down + color_left + color_right )/4.0;
	vec4 blur_color = blur_color1;
	// float noise_val = texture(noise,UV).r+sin(TIME)/PI;
	float noise_val = texture(noise,UV).r+sin(TIME)/PI;
	vec4 finish_color = blur_color;
	// aply the noise and the alpha value when
	finish_color = finish_color-vec4(noise_val,1.0,1.0, 1.0-blur_color.r);
	COLOR = finish_color;
	
}

//void light() {
	// Called for every pixel for every lWight affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
