extends HBoxContainer

@export var player_max_life:float = 100

@onready var battle:Node2D = $MidContainer/Content/Battle
@onready var player1_life_portrait: Sprite2D = $LeftContainer/Content/ProfilePicture

var player1_life:float
var player2_life:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player1_life = player_max_life
	player2_life = player_max_life
	player1_life_portrait.set_max_life(player_max_life)
	#add player2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_buttton_tracker_fail(player_id:int) -> void:
	hit_player(1, player_id)


func _on_buttton_tracker_hit(type: Pointer.HitTypes, player_id:int) -> void:
	var other_player_id = 2 if player_id==1 else 1
	hit_player(type+1, other_player_id)


func hit_player(value:float, player_id:int) -> void:
	battle.hit_player(player_id)
	match player_id:
		1:
			player1_dmg(value)
		2:
			player2_life -= value
		_:
			printerr("Invalid Player ID")


func player1_dmg(value:float) -> void:
	player1_life -= value
	player1_life_portrait.set_life(player1_life)
