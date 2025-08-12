class_name CharacterData
extends CardData

@export var health: int = 50
@export var block: int = 0
@export var strength: int = 5
@export var energy: int = 1
@export var money: int = 3


func _init(p_card_name: String = "", p_health: int = 50,
		p_block: int = 0, p_strength: int = 5, p_energy: int = 1, p_money: int = 3) -> void:
	super(p_card_name)
	
	health = p_health
	block = p_block
	strength = p_strength
	energy = p_energy
	money = p_money
