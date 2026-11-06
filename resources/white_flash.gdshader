shader_type spatial;
render_mode unshaded, cull_disabled;

uniform sampler2D tex : source_color, filter_nearest, repeat_disable;
uniform float flash_intensity : hint_range(0.0, 1.0);

void fragment() {
    vec4 c = texture(tex, UV);

    ALBEDO = mix(c.rgb, vec3(1.0), flash_intensity);
    ALPHA = c.a;
}