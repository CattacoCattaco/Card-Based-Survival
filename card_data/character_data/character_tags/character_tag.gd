class_name CharacterTag
extends Resource

@export var tag_name: String = ""
@export var parent_tag: CharacterTag = null


func _init(p_tag_name: String = "", p_parent_tag: CharacterTag = null) -> void:
	tag_name = p_tag_name
	parent_tag = p_parent_tag


func inherits(tag: CharacterTag) -> bool:
	if tag in [self, parent_tag]:
		return true
	
	if not parent_tag:
		return false
	
	return parent_tag.inherits(tag)
