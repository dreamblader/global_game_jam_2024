extends Node2D

@export var max_life:float
@export var my_texture:CompressedTexture2D
@export var stages_sound:Array[AudioStream]

@onready var progress:TextureProgressBar = $TextureProgressBar
@onready var sprite:Sprite2D = $Sprite
@onready var sfx:AudioStreamPlayer = $SFX

var states:int
var last_state:int = -1


func _ready() -> void:
	states = sprite.hframes
	sprite.texture = my_texture
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
	sprite.frame = state
	sprite.scale = Vector2(inflate,inflate)
	play_sound(state)


func play_sound(state: int) -> void:
	if last_state != state && state<stages_sound.size():
		last_state = state
		sfx.stream = stages_sound[state]
		sfx.play()
