shader_type canvas_item;

uniform sampler2D lifeTimeColorGradient;
uniform sampler2D overlapGradient;
uniform sampler2D noise1 : repeat_enable;
uniform sampler2D noise2 : repeat_enable;
uniform vec2 scroll1 = vec2(0.2, -0.3);
uniform vec2 scroll2 = vec2(0.1, -0.4);
uniform float noise2_scale = 0.5;
uniform float sharpness = 6.0;

void fragment() {
	float particleSeed = COLOR.r / (COLOR.r + COLOR.b + COLOR.g);
	
	float adjustedTime = TIME + particleSeed * 11374.293247;
	float noise1_intensity = texture(noise1, UV + adjustedTime * scroll1).r;
	float noise2_intensity = texture(noise2, noise2_scale * (UV + adjustedTime * scroll2)).r;
	float intensity = noise1_intensity * noise2_intensity;
	
	vec4 overlapColor = texture(overlapGradient, vec2(intensity * 3.5));
	vec4 lifetimeColor = texture(lifeTimeColorGradient, vec2(COLOR.a));
	COLOR = lifetimeColor * overlapColor;
	COLOR.a *= min(1.0, intensity * sharpness) * texture(TEXTURE, UV).a;
}
