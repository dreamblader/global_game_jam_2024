extends Node2D

@onready var player1: Sprite2D = $Character
@onready var player2: Sprite2D = $Character2


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
			player2.win()
			player1.dead= true
		2:
			player1.win()
			player2.dead = true
		_:
			printerr("Invalid Player ID")


func player_lose_timeout(player_id:int) -> void:
		match player_id:
			1:
				player2.win()
			2:
				player1.win()
			_:
				printerr("Invalid Player ID")
