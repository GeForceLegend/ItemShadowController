#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec4 vertexColor;
in vec4 shadow;
in vec2 texCoord0;
in vec2 texCoord1;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
    if (color.a < 0.1) {
        discard;
    }
    if (abs(color.a - 243.0 / 255.0) > 0.5 / 255.0) {
        color *= vertexColor;
    } else {
        color.w = 1.0;
    }
    color *= shadow * ColorModulator;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
