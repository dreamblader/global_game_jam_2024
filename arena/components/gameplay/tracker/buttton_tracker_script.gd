extends Node2D

@export var player_id:int = 1
@export var prompt_size: float = 10.0
@export var loop_point: float = 180.0
@export var pointer_min_speed: float = 20.0
@export var max_prompt_side: int = 5
@export var prompt_num_start_left:int = 1
@export var prompt_num_start_right:int = 1
@export var prompt_radius_start: float = 35.0
@export var prompt_angle_position_distance: float = 10.0
@export var prompt_scene:PackedScene
@export var prompt_distance_of_border: float = 60
@export var prompt_textures: Array[CompressedTexture2D]

@onready var pointer_a: Pointer = $PointerA
@onready var pointer_b: Pointer = $PointerB

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
var left_arc: Vector2 = Vector2(-90, -270)
var right_arc: Vector2 = Vector2(-90, 90)
var right_arc_positions: Array[float] 
var left_arc_positions: Array[float] 

signal hit(type:Pointer.HitTypes, id:int)
signal fail(id:int)

func _ready() -> void:
	rng.randomize()
	init_arc_positions(1)
	init_arc_positions(-1)
	spawn_prompts(right_arc, 1)
	spawn_prompts(left_arc, -1)


func init_arc_positions(side: int)-> void:
	var margin:float = 20
	var my_arc:Vector2 = right_arc if side > 0 else left_arc
	var my_positions: Array[float]  = right_arc_positions if side > 0 else left_arc_positions
	var current_position:float = my_arc.x+((margin+prompt_radius_start)*side)
	while is_current_position_final(current_position, my_arc.y-(margin*side), side):
		my_positions.append(current_position)
		current_position += side*prompt_angle_position_distance


func is_current_position_final(current_position:float, end_position:float, side:int) -> bool:
	if side > 0:
		return current_position <= end_position
	else:
		return current_position >= end_position


func spawn_prompts(circular_quarter:Vector2, side:int) -> void:
	var positions: Array[float] = right_arc_positions.duplicate() if side > 0 else left_arc_positions.duplicate()
	var texture_id = 1  if side > 0 else 0
	var prompt_num_start:int =  prompt_num_start_right if side > 0 else prompt_num_start_left
	for prompt_num in range(prompt_num_start):
		var new_prompt = prompt_scene.instantiate()
		var position_index = rng.randi_range(0, positions.size()-1)
		var angle_position = positions.pop_at(position_index)
		prints("at angle", angle_position, "SPAWN")
		add_child(new_prompt)
		new_prompt.set_size(prompt_size)
		new_prompt.sprite.rotation_degrees = angle_position
		new_prompt.sprite.texture = prompt_textures[texture_id]
		new_prompt.position = get_prompt_position_based_on_angle(angle_position)


func _process(delta:float) -> void:
	move_pointer(pointer_a, delta, true)
	move_pointer(pointer_b, delta, false)


func move_pointer(pointer: Pointer, delta:float, clockwise:bool) -> void:
	var inversion: int = 1 if clockwise else -1
	var my_arc: Vector2 = left_arc if clockwise else right_arc
	pointer.move_circular(delta, clockwise)
	
	if pointer.rotation_degrees*inversion >= loop_point:
		pointer.reset()
		if clockwise:
			prompt_num_start_left = min(prompt_num_start_left+1, max_prompt_side)
		else:
			prompt_num_start_right = min(prompt_num_start_right+1, max_prompt_side)
		spawn_prompts(my_arc, -inversion)


func get_prompt_position_based_on_angle(angle:float) -> Vector2:
	return Vector2(prompt_distance_of_border*cos(deg_to_rad(angle)), prompt_distance_of_border*sin(deg_to_rad(angle)))


func _on_pointer_a_hit(hit_type: Pointer.HitTypes) -> void:
	pointer_a.speed += hit_type
	emit_signal("hit", hit_type, player_id)


func _on_pointer_b_hit(hit_type: Pointer.HitTypes) -> void:
	pointer_b.speed += hit_type
	emit_signal("hit", hit_type, player_id)


func _on_pointer_a_fail() -> void:
	pointer_a.speed = max(pointer_a.speed-1.5, pointer_min_speed)
	emit_signal("fail", player_id)


func _on_pointer_b_fail() -> void:
	pointer_b.speed = max(pointer_b.speed-1.5, pointer_min_speed)
	emit_signal("fail", player_id)
