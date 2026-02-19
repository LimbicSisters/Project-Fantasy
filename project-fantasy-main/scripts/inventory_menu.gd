extends Node2D

@onready var selection: Node2D = $Selection
@onready var items: Node2D = $Items
@onready var potion: Node2D = $Items/Potion
var itemToUse
var itemname
var selecting = false

func _ready() -> void:
	for child in items.get_children():
		for grandchild in child.get_children():
			if grandchild is Label:
				grandchild.text = (child.name + ": " + str(Inventory.Inventory[child.name]))


func _on_potion_use_pressed() -> void:
	itemname = "Potion"
	if Inventory.Inventory[itemname] >= 1 and not selecting:
		itemToUse = potion
		selection.visible = true
		selecting = true

func _on_paul_pressed() -> void:
	if selecting:
		itemToUse.use(Paul)
		itemToUse.get_child(1).text = (itemname + ": " + str(Inventory.Inventory[itemname]))

func _on_ryka_pressed() -> void:
	if selecting:
		itemToUse.use(Ryka)
		itemToUse.get_child(1).text = (itemname + ": " + str(Inventory.Inventory[itemname]))
		selection.visible = false
		selecting = false
