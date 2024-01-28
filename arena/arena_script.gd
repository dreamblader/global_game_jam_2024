extends HBoxContainer

@export var player_max_life:float = 100
@export var round_time:float = 20.0

@onready var battle:Node2D = $MidContainer/Content/Battle
@onready var player1_tracker: Node2D = $LeftContainer/Content/ButttonTracker
@onready var player1_life_portrait: Node2D = $LeftContainer/Content/ProfilePicture
@onready var player2_tracker: Node2D = $RightContainer/Content/ButttonTracker
@onready var player2_life_portrait: Node2D = $RightContainer/Content/ProfilePicture
@onready var timer:Timer = $Timer
@onready var time_display:Label = $MidContainer/Label
@onready var music:AudioStreamPlayer = $Music
@onready var buttons_player1: Node2D = $LeftContainer/Content/Butons
@onready var buttons_player2: Node2D = $RightContainer/Content/Butons

signal end(winner_player_id:int)

var player1_life:float
var player2_life:float

func _input(event: InputEvent) -> void:
	if event.is_action("tickle_a1"):
		buttons_player1.change_button(1,  event.is_pressed())
	if event.is_action("tickle_b1"):
		buttons_player1.change_button(2,  event.is_pressed())
	if event.is_action("tickle_a2"):
		buttons_player2.change_button(1,  event.is_pressed())
	if event.is_action("tickle_b2"):
		buttons_player2.change_button(2,  event.is_pressed())


func _ready() -> void:
	player1_life = player_max_life
	player2_life = player_max_life
	player1_life_portrait.set_max_life(player_max_life)
	player2_life_portrait.set_max_life(player_max_life)


func start() -> void:
	timer.wait_time = round_time
	timer.start()
	time_display.text = str(round_time)
	player1_tracker.start_tracker()
	player2_tracker.start_tracker()
	music.play()


func _process(delta: float) -> void:
	time_display.text = str(int(timer.time_left))


func _on_buttton_tracker_fail(player_id:int) -> void:
	hit_player(1, player_id)


func _on_buttton_tracker_hit(type: Pointer.HitTypes, player_id:int) -> void:
	var other_player_id = 2 if player_id==1 else 1
	hit_player(type+1, other_player_id)


func hit_player(value:float, player_id:int) -> void:
	battle.hit_player(player_id)
	player_dmg(player_id, value)


func player_dmg(player_id:int, value:float) -> void:
	var player_life: float
	var player_portrait:Node2D
	match player_id:
		1:
			player1_life -= value
			player_life = player1_life
			player_portrait = player1_life_portrait
		2:
			player2_life -= value
			player_life = player2_life
			player_portrait = player2_life_portrait
		_:
			printerr("Invalid Player ID")
	player_portrait.set_life(player_life)
	if player_life <= 0:
		player1_tracker.kill_tracker()
		player2_tracker.kill_tracker()
		battle.player_dies(player_id)


func _on_timer_timeout() -> void:
	if player1_life == player2_life:
		print("DRAW")
		pass #DRAW
	else:
		var loser_id = 1 if player1_life<player2_life else 2
		player1_tracker.kill_tracker()
		player2_tracker.kill_tracker()
		battle.player_lose_timeout(loser_id)
