shader_type particles;

uniform float rows = 4;
uniform float spacing = 1.0;

uniform sampler2D heightmap;
uniform sampler2D noisemap;
uniform sampler2D diffuse;

uniform sampler2D masks;

uniform float amplitude = 0.0;
uniform vec2 heightmap_size = vec2(2048.0,2048.0);

float get_height(vec2 pos) {
	pos -= 0.5 * heightmap_size;
	pos /= heightmap_size;
	//pos.x = 1.0-pos.x;
	//pos.x = pos.x*(-1.0);
	//pos.y = pos.y*(-1.0);
	
	return  (texture(heightmap, pos).r - 0.347) * 127.026 ;
	
}

vec4 get_color(vec2 pos) {
	pos -= 0.5 * heightmap_size;
	pos /= heightmap_size;
	return texture(diffuse, pos).rgbb;
}

vec4 get_masks(vec2 pos) {
	pos -= 0.5 * heightmap_size;
	pos /= heightmap_size;
	return texture(masks, pos).rgba;
}

void vertex() {
	vec3 pos = vec3(0.0,0.0,0.0);	
	pos.z = float(INDEX);
	pos.x = mod(pos.z,rows);
	pos.z = (pos.z - pos.x) / rows;

	pos.x -= rows * 0.5;
	pos.z -= rows * 0.5;
	
	
	
	pos *= spacing;
	
	
	pos.x +=EMISSION_TRANSFORM[3][0] - mod(EMISSION_TRANSFORM[3][0], spacing);
	pos.z +=EMISSION_TRANSFORM[3][2] - mod(EMISSION_TRANSFORM[3][2], spacing);
	
	vec3 noise = texture(noisemap, pos.xz * 0.01).rgb * 4.0;



	
	pos.x += noise.x * spacing;
	pos.z += noise.z * spacing;
	
	// pos.y = get_height(pos.xz) * get_mask(pos.xz).r;
	pos.y = get_height(pos.xz) - ((1.0 - get_masks(pos.xz).r) * 10.0);
	// pos.y = get_masks(pos.xz).r;


	TRANSFORM[0][0] = noise.x * 2.0;
	TRANSFORM[1][1] = noise.x * 2.0;
	TRANSFORM[2][2] = noise.x * 2.0;

	//TRANSFORM[0][0] = 20.0;
	//TRANSFORM[1][1] = 20.0;
	//TRANSFORM[2][2] = 20.0;
	
	// rotate our transform
	TRANSFORM[0][0] = cos(noise.z * 8.0);
	TRANSFORM[0][2] = -sin(noise.z * 8.0);
	TRANSFORM[2][0] = sin(noise.z * 8.0);
	TRANSFORM[2][2] = cos(noise.z * 8.0);
	
	TRANSFORM[3][0] = pos.x;
	TRANSFORM[3][1] = pos.y + 1.5;
	TRANSFORM[3][2] = pos.z;
	
	COLOR = vec4(0.0, 1.0, 0.0, 0.0);
	COLOR = get_color(pos.xz);
	

}