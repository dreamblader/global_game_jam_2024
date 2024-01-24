extends Node2D

@export var pointer_a_speed: float = 25.0
@export var pointer_b_speed: float = 25.0
@export var prompt_size: float = 20.0
@export var loop_point: float = 180.0
@export var init_degress:float = 20.0

@onready var pointer_a: Pointer = $PointerA
@onready var pointer_b: Pointer = $PointerB

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tickle_a"):
		check_correct_input(pointer_a)
	
	if event.is_action_pressed("tickle_b"):
		check_correct_input(pointer_b)


func _process(delta:float) -> void:
	move_pointer(pointer_a, delta, pointer_a_speed, false)
	move_pointer(pointer_b, delta, pointer_b_speed, true)


func move_pointer(pointer: Pointer, delta:float, speed:float, inverse:bool) -> void:
	var inversion: int = -1 if inverse else 1
	
	pointer.rotation_degrees += speed*delta*inversion
	if pointer.rotation_degrees*inversion >= loop_point:
		pointer.rotation_degrees = init_degress*inversion


func check_correct_input(pointer: Pointer) -> void:
	print(check_pointer_distance_prompt(pointer, pointer.get_overlapping_areas()))


func check_pointer_distance_prompt(pointer:Pointer, areas: Array[Area2D]) -> float:
	for area in areas:
		if area.is_in_group("prompt"):
			return pointer.tip.global_position.distance_to(area.global_position)
	return -1


func _on_pointer_a_area_entered(area: Area2D) -> void:
	print(check_pointer_distance_prompt(pointer_a, [area]))


func _on_pointer_a_area_exited(area: Area2D) -> void:
	print(check_pointer_distance_prompt(pointer_a, [area]))
