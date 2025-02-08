// NOTE: Shader automatically converted from Godot Engine 4.4.beta2's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;
uniform ivec2 albedo_texture_size;
uniform float point_size : hint_range(0.1, 128.0, 0.1);

uniform float roughness : hint_range(0.0, 1.0);
uniform sampler2D texture_metallic : hint_default_white, filter_linear_mipmap, repeat_enable;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness : hint_roughness_r, filter_linear_mipmap, repeat_enable;

uniform float specular : hint_range(0.0, 1.0, 0.01);
uniform float metallic : hint_range(0.0, 1.0, 0.01);

uniform vec3 uv1_scale;
uniform vec3 uv1_offset;
uniform vec3 uv2_scale;
uniform vec3 uv2_offset;
const vec2 size = vec2(1.,1.);
const float corner_radius = .05;

void vertex() {
	UV = UV * uv1_scale.xy + uv1_offset.xy;
}

float rectangle(vec2 position) {
    vec2 component_wise_edge_distance = abs(position) - (vec2(0.5, 0.5) * size - corner_radius);
    float outside_distance = length(max(component_wise_edge_distance, 0));
    float inside_distance = min(max(component_wise_edge_distance.x, component_wise_edge_distance.y), 0);
    return outside_distance + inside_distance;
}

void fragment() {
	vec2 base_uv = UV;

	vec4 albedo_tex = texture(texture_albedo, base_uv);
	ALBEDO = albedo.rgb * albedo_tex.rgb;
    float d = rectangle((UV - 0.5) * size);

    if (d < corner_radius) {
        ALPHA = 1.0;
    } else {
        ALPHA = 0.0; // Transparent outside the rounded rectangle
    }

	float metallic_tex = dot(texture(texture_metallic, base_uv), metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	SPECULAR = specular;

	vec4 roughness_texture_channel = vec4(1.0, 0.0, 0.0, 0.0);
	float roughness_tex = dot(texture(texture_roughness, base_uv), roughness_texture_channel);
	ROUGHNESS = roughness_tex * roughness;
}
