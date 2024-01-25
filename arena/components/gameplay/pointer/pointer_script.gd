extends Area2D
class_name Pointer

@export var action_name: String = ""
@export var speed: float = 25.0
@export var init_position: Vector2 = Vector2(0,0)
@export var init_rotation_degrees: float = 0
@export var critical_distance: float = 3

@onready var tip: Node2D = $Tip

signal hit(critical:bool)


func _ready() -> void:
	reset()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(action_name):
		check_correct_input()


func get_angular_speed() -> float:
	return speed/tip.position.y


func move(delta:float, direction:Vector2) -> void:
	self.position += delta*speed*direction


func move_circular(delta:float, clockwise:bool=true) -> void:
	var inversion: int = 1 if clockwise else -1
	self.rotation += delta*get_angular_speed()*inversion


func check_correct_input() -> void:
	var correct_distance: float = check_pointer_distance_prompt(get_overlapping_areas())
	print(correct_distance)
	if correct_distance >= 0:
		emit_signal("hit", correct_distance<critical_distance)


func check_pointer_distance_prompt(areas: Array[Area2D]) -> float:
	for area in areas:
		if area.is_in_group("prompt"):
			return tip.global_position.distance_to(area.global_position)
	return -1


func reset() -> void:
	self.position = init_position
	self.rotation_degrees = init_rotation_degrees
