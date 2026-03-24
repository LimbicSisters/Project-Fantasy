extends Node

# ------ MOVE ARROW DOWN ------
# Function to move arrow down a target or more depending
func move_arrow_down(enemytargets, arrow1, arrow2, arrow3, target):
	# Variable that will set the new target
	var newtarget
	# Match the size of the list of enemies
	match enemytargets.size():
		# If it is 1
		1:
			# Set arrow 2 and 3 to not visible
			arrow2.visible = false
			arrow3.visible = false
			# Set arrow 1 to visible and update target
			arrow1.visible = true
			newtarget = 1
		# If it is 2
		2:
			# Match current target
			match target:
				# If it is 1
				1:
					# Set arrow 1 to not visible
					arrow1.visible = false
					# If enemy 2 is not dead:
					if not enemytargets[1].dead:
						# Set arrow 2 to visible and update target
						arrow2.visible = true
						newtarget = 2
					# Otherwise
					else:
						# Set arrow 1 to visible
						arrow1.visible = true
						# Set new target to 1
						newtarget = 1
				# If it is 2
				2:
					# Set arrow 2 to not visible
					arrow2.visible = false
					# If first enemy is not dead:
					if not enemytargets[0].dead:
						# Set arrow 1 to visible and update target
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
