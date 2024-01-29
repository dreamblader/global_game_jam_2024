extends Node2D

@onready var player1: Sprite2D = $Character
@onready var player2: Sprite2D = $Character2

signal over

func reset() -> void:
	player1.reset()
	player2.reset()


func hit_player(player_id:int) -> void:
	match player_id:
		1:
			player2.tickle()
			player1.hit()
		2:
			player1.tickle()
			player2.hit()
		_:
			printerr("Invalid Player ID")


func player_dies(player_id:int) -> void:
	match player_id:
		1:
			player1.dead= true
		2:
			player2.dead = true
		_:
			printerr("Invalid Player ID")


func player_lose_timeout(player_id:int) -> void:
	var time_to_over:float = 4.0
	
	match player_id:
		-1:
			player1.nah()
			player2.nah()
		1:
			player1.nah()
			player2.win()
		2:
			player1.nah()
			player1.win()
		_:
			printerr("Invalid Player ID")
	
	var tween = create_tween()
	tween.tween_callback(emit_signal.bind("over")).set_delay(time_to_over)


func _on_character_you_died() -> void:
	player2.win()
	emit_signal("over")


func _on_character_2_you_died() -> void:
	player1.win()
	emit_signal("over")
