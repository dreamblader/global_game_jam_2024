extends Node


func game_is_in_mobile() -> bool:
	return OS.has_feature("mobile") || OS.has_feature("web_android") || OS.has_feature("web_ios")
