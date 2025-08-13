class_name ActionCard
extends Card

const CARD_SCENE: PackedScene = preload("res://card/action_card/action_card.tscn")

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
				hand.play_zone.drag_hapenning = false
				hand.play_zone.drag_preview = null
				hand.play_zone.unhighlight()
				
				is_dragging = false
				
				if not is_drag_successful():
					show()


func _on_mouse_entered() -> void:
	if not hand.play_zone.drag_hapenning:
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
	hand.deck_manager.used_cards.append(data)
	
	hand.draw_cards(1)
	
	queue_free()
