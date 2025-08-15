class_name MoveEffect
extends ActionEffect

enum Direction {
	NORTH,
	EAST,
	SOUTH,
	WEST,
}

@export var direction: Direction = Direction.NORTH
@export var amount: int = 1


func _init(p_direction: Direction = Direction.NORTH, p_amount: int = 1) -> void:
	direction = p_direction
	amount = p_amount


func _resolve(action_card: ActionCard) -> void:
	var map_BG: MapBG = action_card.play_zone.map_BG
	
	var move_func: Callable
	match direction:
		Direction.NORTH:
			move_func = map_BG.move_up
		Direction.EAST:
			move_func = map_BG.move_right
		Direction.SOUTH:
			move_func = map_BG.move_down
		Direction.WEST:
			move_func = map_BG.move_left
	
	for i in range(amount):
		move_func.call()
