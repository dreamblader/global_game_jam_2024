extends Node2D
class_name Pointer

enum HitTypes{Nah, Ok, Good, Great}

@export var action_name: String = ""
@export var speed: float = 25.0
@export var radius:float = 60
@export var colission_radius:float = 5.0
@export var init_position: Vector2 = Vector2(0,0)
@export var init_rotation_degrees: float = 0
@export var texture:CompressedTexture2D
@export var hit_distances: Array[float] = [5, 3, 1.5]

@onready var this_area:Area2D = $Area
@onready var collision: CollisionShape2D = $Area/Collision
@onready var sprite:Sprite2D = $Sprite

var lock:bool = false

signal hit(type:HitTypes)
signal fail


func _ready() -> void:
	collision.shape.radius = colission_radius
	this_area.position.y = radius
	set_sprite()
	reset()


func set_sprite() -> void:
	var scale_factor:float = colission_radius/(texture.get_width()/2)
	sprite.texture = texture
	sprite.scale = Vector2(scale_factor, scale_factor)
	sprite.position.y = radius


func _input(event: InputEvent) -> void:
	if !lock && event.is_action_pressed(action_name):
		check_correct_input()


func get_angular_speed() -> float:
	return speed/this_area.position.y


func move(delta:float, direction:Vector2) -> void:
	self.position += delta*speed*direction


func move_circular(delta:float, clockwise:bool=true) -> void:
	var inversion: int = 1 if clockwise else -1
	self.rotation += delta*get_angular_speed()*inversion


func check_correct_input() -> void:
	var correct_distance: float = check_pointer_distance_prompt(this_area.get_overlapping_areas())
	print(correct_distance)
	if correct_distance >= 0:
		pass
		emit_signal("hit", get_distance_hit_type(correct_distance))
	else:
		emit_signal("fail")


func get_distance_hit_type(distance:float) -> HitTypes:
	var result = HitTypes.Nah
	for check in hit_distances:
		if distance <= check:
			result+=1
	return result


func check_pointer_distance_prompt(areas: Array[Area2D]) -> float:
	for area in areas:
		if area.is_in_group("prompt"):
			area.pressed()
			return this_area.global_position.distance_to(area.global_position)
	return -1


func reset() -> void:
	self.position = init_position
	self.rotation_degrees = init_rotation_degrees


func _on_area_area_exited(area: Area2D) -> void:
	if area.is_in_group("prompt") && !area.hit:
		area.forgot()
		print("miss")
		emit_signal("fail")
