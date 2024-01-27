extends Area2D

var hit:bool=false
var size:float = 12.0

@export var scale_size_sprite: float = 12.0

@onready var colission: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite


func set_size(value:float)-> void:
	var new_scale = value/scale_size_sprite
	size = value
	colission.shape.radius = value
	sprite.scale = Vector2(new_scale, new_scale)


func pressed() -> void:
	hit = true
	destroy()


func forgot() -> void:
	destroy()


func destroy() -> void:
	queue_free()
