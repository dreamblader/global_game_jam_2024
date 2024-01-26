extends Node2D

@export var player_id:int = 1
@export var prompt_size: float = 10.0
@export var loop_point: float = 180.0
@export var max_prompt_side: int = 5
@export var prompt_num_start:int = 1
@export var prompt_radius_start: float = 35.0
@export var prompt_scene:PackedScene

@onready var pointer_a: Pointer = $PointerA
@onready var pointer_b: Pointer = $PointerB

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	spawn_prompts(1)
	spawn_prompts(-1)


func spawn_prompts(side:int) -> void:
	var margin:float = 20
	for prompt_num in range(prompt_num_start):
		var new_prompt = prompt_scene.instantiate()
		var angle_position = side*rng.randf_range(prompt_radius_start, loop_point-margin)
		prints("at angle", angle_position, "SPAWN")
		add_child(new_prompt)
		new_prompt.set_size(prompt_size)
		new_prompt.position = get_prompt_position_based_on_angle(angle_position)


func _process(delta:float) -> void:
	move_pointer(pointer_a, delta, true)
	move_pointer(pointer_b, delta, false)


func move_pointer(pointer: Pointer, delta:float, clockwise:bool) -> void:
	var inversion: int = 1 if clockwise else -1
	pointer.move_circular(delta, clockwise)
	
	if pointer.rotation_degrees*inversion >= loop_point:
		pointer.reset()
		spawn_prompts(inversion)


func get_prompt_position_based_on_angle(angle:float) -> Vector2:
	var prompt_distance_of_border = 60
	return Vector2(prompt_distance_of_border*cos(deg_to_rad(angle)), prompt_distance_of_border*sin(deg_to_rad(angle)))

func _on_pointer_a_hit(critical: bool) -> void:
	pass # Replace with function body.


func _on_pointer_b_hit(critical: bool) -> void:
	pass # Replace with function body.


func _on_pointer_a_fail() -> void:
	pass # Replace with function body.


func _on_pointer_b_fail() -> void:
	pass # Replace with function body.
