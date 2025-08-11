shader_type canvas_item;

uniform float epsilon = 0.0001;
uniform vec4 origin : source_color;
uniform vec4 new : source_color;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec4 current_pixel = texture(SCREEN_TEXTURE, SCREEN_UV);

	if (length(current_pixel - origin) < epsilon)
		COLOR = new;
	else
		COLOR = current_pixel;
}