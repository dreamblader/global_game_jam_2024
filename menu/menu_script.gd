extends Control

@onready var menu:Control = $MenuContainer
@onready var animation:AnimationPlayer = $AnimationPlayer

var current_index: int = 0

signal play

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_down"):
		move_index(1)
	if event.is_action_pressed("ui_up"):
		move_index(-1)
	if event.is_action_pressed("ui_accept"):
		confirm_option()


func _ready() -> void:
	animation.play("back_move")
	select_menu()


func move_index(value:int) -> void:
	var menu_size: int = menu.get_child_count()
	unselect_menu()
	current_index += value%menu_size
	current_index = current_index if current_index >= 0 else menu_size-1
	select_menu()


func unselect_menu() -> void:
	menu.get_child(current_index).unselect()


func select_menu() -> void:
	menu.get_child(current_index).select()


func confirm_option() -> void:
	match current_index:
		0:
			emit_signal("play")
		1:
			get_tree().quit()
