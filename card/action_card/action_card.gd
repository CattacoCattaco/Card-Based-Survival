class_name ActionCard
extends Card

@export var effect_label: Label
@export var position_offset_control: ActionCardPositionOffset

var is_dragging: bool


func _ready() -> void:
	position_offset_control.mouse_entered.connect(_on_mouse_entered)
	position_offset_control.mouse_exited.connect(_on_mouse_exited)


func _notification(what: int) -> void:
	match what:
		NOTIFICATION_DRAG_END:
			if is_dragging:
				play_zone.drag_hapenning = false
				play_zone.drag_preview = null
				play_zone.unhighlight()
				
				is_dragging = false
				
				if not is_drag_successful():
					show()


func _on_mouse_entered() -> void:
	if not play_zone.drag_hapenning:
		z_index = 10
		position_offset_control.position = Vector2(0, -10)


func _on_mouse_exited() -> void:
	if z_index == 10 and position_offset_control.position == Vector2(0, -10):
		z_index = 0
		position_offset_control.position = Vector2(0, 0)


func _load_data(new_data: CardData) -> void:
	if not new_data is ActionData:
		return
	
	super(new_data)
	
	effect_label.text = data.effect_text


func play() -> void:
	hand.cards.erase(self)
	
	if from_deck:
		hand.deck_manager.used_cards.append(data)
	
	play_zone.drag_hapenning = false
	play_zone.drag_preview = null
	play_zone.unhighlight()
	
	for effect: ActionEffect in data.effects:
		await effect._resolve(self)
	
	queue_free()
	
	match hand.mode:
		Hand.Mode.MAP_ACTIONS, Hand.Mode.FIGHT_ACTIONS:
			if data.replace:
				hand.draw_cards(1)
		Hand.Mode.SETTINGS_ACTIONS:
			hand.draw_settings_hand()
	
	play_zone.action_played.emit()
