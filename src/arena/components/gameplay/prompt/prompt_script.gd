extends Area2D

var hit:bool=false
var size:float = 12.0

@export var scale_size_sprite: float = 12.0

@onready var colission: CollisionShape2D = $CollisionShape2D
@onready var sprite: Sprite2D = $Sprite

var animation_duration:float = 0.25

func set_size(value:float)-> void:
	var new_scale = value/scale_size_sprite
	size = value
	colission.shape.radius = value
	sprite.scale = Vector2(new_scale, new_scale)


func pressed(crit:bool) -> void:
	hit = true
	var tween:Tween = create_tween()
	tween.tween_property(self, "scale", Vector2(2,2), animation_duration)
	tween.parallel().tween_property(self, "modulate:a", 0, animation_duration)
	tween.tween_callback(destroy)


func forgot() -> void:
	var tween:Tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0,0), animation_duration)
	tween.parallel().tween_property(self, "modulate:a", 0, animation_duration)
	tween.tween_callback(destroy)


func destroy() -> void:
	queue_free()
