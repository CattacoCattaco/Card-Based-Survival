class_name PlayerColorEffect
extends ActionEffect

@export var changes_color_group: bool = true
@export var set_value: int = 0


func _init(p_changes_color_group: bool = true, p_set_value: int = 0) -> void:
	changes_color_group = p_changes_color_group
	set_value = p_set_value


func _resolve(action_card: ActionCard) -> void:
	var settings: Settings = action_card.play_zone.settings
	
	if changes_color_group:
		settings.player_color_coords.y = set_value
	else:
		settings.player_color_coords.x = set_value
	
	settings.show_player_color()
