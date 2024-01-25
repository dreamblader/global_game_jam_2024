extends Node2D

@export var player_id:int = 1
@export var prompt_size: float = 20.0
@export var loop_point: float = 180.0

@onready var pointer_a: Pointer = $PointerA
@onready var pointer_b: Pointer = $PointerB


func _ready() -> void:
	pass


func _process(delta:float) -> void:
	move_pointer(pointer_a, delta, true)
	move_pointer(pointer_b, delta, false)


func move_pointer(pointer: Pointer, delta:float, clockwise:bool) -> void:
	var inversion: int = 1 if clockwise else -1
	pointer.move_circular(delta, clockwise)
	
	if pointer.rotation_degrees*inversion >= loop_point:
		pointer.reset()
