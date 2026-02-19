extends Item

func use(target):
	target.health += 15
	Inventory.Inventory["Potion"] -= 1
