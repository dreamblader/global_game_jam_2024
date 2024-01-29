shader_type canvas_item;

uniform float lod: hint_range(0.0, 100.0) = 0.0;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment() {
    COLOR = textureLod(screen_texture, SCREEN_UV, lod);
}
