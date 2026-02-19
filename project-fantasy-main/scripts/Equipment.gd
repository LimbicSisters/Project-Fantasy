extends Node
class_name Equipment

@export var item_name : String
@export_enum("BWeapon", "RWeapon", "LWeapon", "Helmet", "Boots", "Chestplate", "Gloves", "Leggings") var type
@export_enum("Wooden", "Iron", "Steel", "Dragon", "Godly") var tier

func equip(player):
	if self in Inventory.Inventory:
		var target
		match player:
			Paul:
				target = Paul
			Ryka:
				target = Ryka
		match type:
			"Bweapon":
				add_to_inventory(target, target.WeaponRType)
				add_to_inventory(target, target.WeaponLType)
				target.WeaponRType = (tier + type)
				target.WeaponLType = "Taken"
			"Rweapon":
				add_to_inventory(target, target.WeaponRType)
				target.WeaponRType = (tier + type)
			"Lweapon":
				add_to_inventory(target, target.WeaponLType)
				target.WeaponLType = (tier + type)
			"Helmet":
				add_to_inventory(target, target.Helmet)
				target.Helmet = (tier + type)
			"Boots":
				add_to_inventory(target, target.Boots)
				target.Boots = (tier + type)
			"Chestplate":
				add_to_inventory(target, target.Chestplate)
				target.Chestplate = (tier + type)
			"Gloves":
				add_to_inventory(target, target.Gloves)
				target.Gloves = (tier + type)
			"Leggings":
				add_to_inventory(target, target.Leggings)
				target.Leggings = (tier + type)
				
func add_to_inventory(target, itemslot):
	if target.itemslot != "None":
		if target.itemslot in Inventory.Inventory:
			Inventory.Inventory[target.itemslot] += 1
		else:
			Inventory.Inventory[target.itemslot] = 1
