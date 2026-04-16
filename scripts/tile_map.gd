extends TileMapLayer
@export var noise_height_texture : NoiseTexture2D
var noise : Noise

var width = 200
var height = 200
#var noise_val_arr = []

@onready var tile_map = $"."

var source_id = 0

#var land_atlas = Vector2i(0,3)
#var path_atlas = Vector2i(1,1)

var path_tiles_arr = []
var grass_tiles_arr = []

var terrain_path_int = 0
var grass_path_int = 1

func _ready() -> void:
	noise = noise_height_texture.noise
	generate_world()
	
func generate_world():
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val = noise.get_noise_2d(x,y)
			
			if x == -width/2 or x == width/2-1 or y == -height/2 or y == height/2-1:
				tile_map.set_cell(Vector2i(x,y),1,Vector2i(0,0))
				pass   
			elif noise_val > 0.0 and noise_val < 0.070:
				grass_tiles_arr.append(Vector2i(x,y))
				path_tiles_arr.append(Vector2i(x,y))
				#tile_map.set_cell(Vector2(x,y), source_id, path_atlas)
				pass
			#SO ALL TILES WILL BE MADE GRASS BEFOREHAND!
			else:
				grass_tiles_arr.append(Vector2i(x,y))
			#print(noise_val)
			#noise_val_arr.append(noise_val)
	#SETS ALL TILES AS GRASS, THEN PUTS PATH OVER! TER
	tile_map.set_cells_terrain_connect(grass_tiles_arr,0, grass_path_int,false)
	tile_map.set_cells_terrain_connect(path_tiles_arr,0, terrain_path_int,false)
	#print(noise_val_arr.max())
	#print(noise_val_arr.min())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
