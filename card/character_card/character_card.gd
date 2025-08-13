class_name CharacterCard
extends Card

@export var health_label: Label
@export var block_label: Label
@export var strength_label: Label
@export var energy_label: Label
@export var money_label: Label

@export var fight_deck: Array[ActionData]
@export var movement_deck: Array[ActionData]

var current_health: int
var current_energy: int
var current_money: int


func _load_data(new_data: CardData) -> void:
	if new_data is not CharacterData:
		return
	
	super(new_data)
	
	current_health = data.health
	current_energy = data.energy
	current_money = data.money
	
	update_stats()


func update_stats() -> void:
	update_health()
	update_block()
	update_strength()
	update_energy()
	update_money()


func update_health() -> void:
	health_label.text = "%s/%s" % [data.health, current_health]


func update_block() -> void:
	block_label.text = str(data.block)


func update_strength() -> void:
	strength_label.text = str(data.strength)


func update_energy() -> void:
	energy_label.text = "%s/%s" % [data.energy, current_energy]


func update_money() -> void:
	money_label.text = str(current_money)
