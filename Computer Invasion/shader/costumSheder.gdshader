shader_type spatial;

uniform sampler2D DEPTH_TEXTURE : hint_depth_texture;

void vertex() {
	// Настройка обводки
    vec4 ec_position = (VIEW_MATRIX * vec4(VERTEX, 1.0)).xyzw;
    vec4 clip_position = (PROJECTION_MATRIX * ec_position);
    vec3 clip_ec = clip_position.xyz / clip_position.w;
    vec2 screen_position = (clip_ec.xy + vec2(1.0)) / 2.0;

    // Определение контура объекта
    vec2 outline = vec2(0.1, 0.0); // Увеличен размер обводки
    vec2 uv = screen_position;

    if (uv.x < outline.x || uv.x > 1.0 - outline.x || uv.y < outline.y || uv.y > 1.0 - outline.y) {
        VERTEX += normalize(NORMAL) * 0.02; // Увеличен размер обводки
        COLOR = vec4(0.0, 0.0, 1.0, 1.0); // Синий цвет обводки
    }
}

void fragment() {
	ALBEDO.rgb = vec3(0.0, 0.0, 0.0);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
