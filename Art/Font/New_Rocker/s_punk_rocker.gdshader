shader_type canvas_item;
render_mode unshaded;

uniform float outline_size_px = 2.0;
uniform float gradient_offset = 0.0;           // Shift gradient start point
uniform float gradient_blend_sharpness = 1.0;  // Control how fast it blends (>=1.0)

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // Simulated outline
    vec2 pixel_offset = outline_size_px * TEXTURE_PIXEL_SIZE;

    float outline = 0.0;
    outline += texture(TEXTURE, UV + vec2( pixel_offset.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(-pixel_offset.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(0.0,  pixel_offset.y)).a;
    outline += texture(TEXTURE, UV + vec2(0.0, -pixel_offset.y)).a;

    float center = tex.a;
    float alpha = max(center, outline * 0.25);

    vec4 final_color;

    if (center > 0.0) {
        // Diagonal blend coordinate
        float g = (SCREEN_UV.x + SCREEN_UV.y) * 0.5 + gradient_offset;

        // Falloff control: sharpness of blend (>=1.0)
        g = clamp(g, 0.0, 1.0);
        g = pow(g, gradient_blend_sharpness); // nonlinear blend

        vec4 pink = vec4(1.0, 0.2, 0.6, 1.0);   // Hot pink
        vec4 green = vec4(0.0, 1.0, 0.4, 1.0);  // Neon green

        final_color = mix(pink, green, g);
    } else if (alpha > 0.0) {
        final_color = vec4(1.0, 1.0, 0.0, 1.0); // Yellow outline
    } else {
        discard;
    }

    COLOR = vec4(final_color.rgb, alpha);
}
