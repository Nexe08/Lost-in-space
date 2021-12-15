shader_type canvas_item;
uniform sampler2D emmision_texture;
uniform vec4 glow_color: hint_color = vec4(1f, 1f, 1f, 1f);

void fragment() {
    vec4 current_color = texture(TEXTURE, UV);
    vec4 emmision_color = texture(emmision_texture, UV);
    
    if (emmision_color.r > 0f) {
        COLOR = (emmision_color + glow_color);
    }
    else {
        COLOR = current_color;
    }
}