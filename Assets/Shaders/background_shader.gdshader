shader_type canvas_item;

uniform vec2 scroll1 = vec2(0.1,0.1);
uniform vec2 scroll2 = vec2(0.2,0.2);
uniform sampler2D textureNoise : repeat_enable;

void fragment() {
	float textureColor1 = texture(TEXTURE, UV + scroll1 * TIME*0.15).r;
	float textureColor2 = texture(textureNoise, UV + scroll2 * TIME*0.25).r;
	float energy = textureColor1 * textureColor2;
	COLOR = vec4(energy, energy, energy, 1 )*2.5;
}

