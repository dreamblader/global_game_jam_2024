extends Sprite2D

@export var max_life:float
@export var my_texture:CompressedTexture2D

@onready var progress:TextureProgressBar = $TextureProgressBar

var states:int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	states = hframes
	texture = my_texture
	progress.max_value = max_life


func set_max_life(new_max:float) -> void:
	max_life = new_max
	progress.max_value = max_life


func set_life(life:float) -> void:
	var life_left: float = max_life-life
	var state_treshold: float = max_life/states
	var state: int = floor(life_left/state_treshold)
	var inflate = 1.0 + (life_left/1000)
	progress.value = life_left
	frame = state
	scale = Vector2(inflate,inflate)
