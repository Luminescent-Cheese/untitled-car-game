extends Node2D

@export var noise_height_text : NoiseTexture2D
@onready var RNG = RandomNumberGenerator.new()
var noise : Noise

var width: int = 500
var height: int = 500

@onready var LandTiles = $LandTiles

var source_id = 1
var floor_atlas = Vector2i(0,0)
var wall_atlas = Vector2i(9,2)

var cliff_tiles_arr = []
var terrain_cliff_int = 0

func _ready():
	find_seed()
	noise = noise_height_text.noise
	generate_world()

func find_seed():
	var attemptSeed = int(RNG.randf_range(0, 100000))
	noise = noise_height_text.noise
	noise.seed = attemptSeed
	if noise.get_noise_2d(1,1) < -0.1:
		return
	else:
		find_seed()
	
func generate_world():
	#takes the noise, and makes the map with it
	for x in range(-width/2, width/2):
		for y in range(-height/2, height/2):
			var noise_val = noise.get_noise_2d(x,y)
			if noise_val >= 0:
				LandTiles.set_cell(Vector2(x,y), source_id, wall_atlas)
			elif noise_val >= -0.1:
				cliff_tiles_arr.append(Vector2i(x,y))
			elif noise_val < -0.1:
				pass
				#LandTiles.set_cell(Vector2(x,y), source_id, floor_atlas)
	LandTiles.set_cells_terrain_connect(cliff_tiles_arr, terrain_cliff_int, 0)
