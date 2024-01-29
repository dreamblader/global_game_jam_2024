extends Sprite2D

@export var my_texture:CompressedTexture2D
@onready var animation:AnimationPlayer = $AnimationPlayer
var dead:bool = false
var animation_lock:bool=false

signal you_died

func _ready() -> void:
	animation.play("idle")
	self.texture = my_texture


func reset() -> void:
	animation.play("RESET")
	dead = false
	animation_lock=false


func tickle() -> void:
	if !animation_lock:
		animation.play("RESET")
		animation.play("tickle")


func hit() -> void:
	if !animation_lock:
		animation.play("RESET")
		animation.play("hit")


func win() -> void:
	if !animation_lock:
		animation_lock = true
		animation.play("win")


func nah() -> void:
	if !animation_lock:
		animation_lock = true
		animation.play("nah")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "hit" && dead:
		animation.play("dead")
	elif anim_name == "dead":
		visible = false
		emit_signal("you_died")
	elif dead:
		animation_lock = true
		animation.play("hit")
	else:
		animation.play("idle")
