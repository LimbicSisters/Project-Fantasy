extends Node

func move_arrow_down(enemytargets, arrow1, arrow2, arrow3, target):
	var newtarget
	match enemytargets.size():
		1:
			arrow2.visible = false
			arrow3.visible = false
			arrow1.visible = true
			newtarget = 1
		2:
			match target:
				1:
					arrow1.visible = false
					if not enemytargets[1].dead:
						arrow2.visible = true
						newtarget = 2
					else:
						arrow1.visible = true
						newtarget = 1
				2:
					arrow2.visible = false
					if not enemytargets[0].dead:
						arrow1.visible = true
						newtarget = 1
					else:
						arrow2.visible = true
						newtarget = 2
				3:
					arrow3.visible = false
					if not enemytargets[0].dead:
						print("TEST")
						arrow1.visible = true
						newtarget = 1
					elif not enemytargets[1].dead:
						arrow2.visible = true
						newtarget = 2
					else:
						arrow3.visible = true
						newtarget = 3
		3:
			match target:
				1:
					arrow1.visible = false
					if not enemytargets[1].dead:
						arrow2.visible = true
						newtarget = 2
					elif not enemytargets[2].dead:
						arrow3.visible = true
						newtarget = 3
					else:
						arrow1.visible = true
						newtarget = 1
				2:
					arrow2.visible = false
					if not enemytargets[2].dead:
						arrow3.visible = true
						newtarget = 3
					elif not enemytargets[0].dead:
						arrow1.visible = true
						newtarget = 1
					else:
						arrow2.visible = true
						newtarget = 2
				3:
					arrow3.visible = false
					if not enemytargets[0].dead:
						print("TEST")
						arrow1.visible = true
						newtarget = 1
					elif not enemytargets[1].dead:
						arrow2.visible = true
						newtarget = 2
					else:
						arrow3.visible = true
						newtarget = 3
	return newtarget

func move_arrow_up(enemytargets, arrow1, arrow2, arrow3, target):
	var newtarget
	match enemytargets.size():
		1:
			arrow2.visible = false
			arrow3.visible = false
			arrow1.visible = true
			newtarget = 1
		2:
			match target:
				1:
					arrow1.visible = false
					if not enemytargets[1].dead:
						arrow2.visible = true
						newtarget = 2
					else:
						arrow1.visible = true
						newtarget = 1
				2:
					arrow2.visible = false
					if not enemytargets[0].dead:
						arrow1.visible = true
						newtarget = 1
					else:
						arrow2.visible = true
						newtarget = 2
				3:
					arrow3.visible = false
					if not enemytargets[0].dead:
						arrow1.visible = true
						newtarget = 1
					elif not enemytargets[1].dead:
						arrow2.visible = true
						newtarget = 2
					else:
						arrow3.visible = true
						newtarget = 3
		3:
			match target:
				3:
					arrow3.visible = false
					if not enemytargets[1].dead:
						arrow2.visible = true
						newtarget = 2
					elif not enemytargets[0].dead:
						arrow1.visible = true
						newtarget = true
					else:
						arrow3.visible = true
						newtarget = 3
				2:
					arrow2.visible = false
					if not enemytargets[0].dead:
						arrow1.visible = true
						newtarget = 1
					elif not enemytargets[2].dead:
						arrow3.visible = true
						newtarget = 3
					else:
						arrow2.visible = true
						newtarget = 2
				1:
					arrow1.visible = false
					if not enemytargets[2].dead:
						arrow3.visible = true
						newtarget = 3
					elif not enemytargets[1].dead:
						arrow2.visible = true
						newtarget = 2
					else:
						arrow1.visible = true
						newtarget = 1
	return newtarget

func healarrow(arrow1, arrow2, target):
	var newtarget
	if target == 4:
		arrow1.visible = false
		newtarget = 5
		arrow2.visible = true
	else:
		arrow2.visible = false
		newtarget = 4
		arrow1.visible = true
	return newtarget
	
