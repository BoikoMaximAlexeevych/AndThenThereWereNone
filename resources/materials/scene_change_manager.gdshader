shader_type canvas_item;

uniform float circle_expansion: hint_range(0.0, 1.2, 0.01);
uniform vec4 color : source_color = vec4(0.0, 0.0, 0.0, 1.0);

void fragment() {
	float radius = 1.;
    vec2 uv = UV;
	uv = (uv - vec2(0.5,0.5));
    uv.x *= (float(SCREEN_PIXEL_SIZE.y) / float(SCREEN_PIXEL_SIZE.x));
	
    float d = length(uv);

    if (d > radius * circle_expansion)
        COLOR = color;
    else
        discard;
}
