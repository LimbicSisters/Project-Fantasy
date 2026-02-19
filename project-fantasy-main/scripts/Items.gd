extends Node
class_name Item

@export var item_name : String
@export_enum("PlayerEffect", "Curse") var type

func use_check():
	if item_name in Inventory.Inventory:
		if Inventory.Inventory[item_name] == 1:
			Inventory.Inventory.erase(item_name)
		else:
			Inventory.Inventory[item_name] -= 1
		return true
	return false
