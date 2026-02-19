extends Node

func move_arrow_down(Holyactive, target1, target2, target3, target4, target5, arrow1, arrow2, arrow3, arrow4, arrow5, target, enemylist):
	var newtarget
	match target:
		1:
			arrow1.visible = false
			if not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
			elif not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
			elif Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
			elif Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
			elif not target1.dead:
				newtarget = move_arrow(arrow1, 1)
		2:
			arrow2.visible = false
			if not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
			elif Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
			elif Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
			elif not target1.dead:
				newtarget = move_arrow(arrow1, 1)
			elif not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
		3:
			arrow3.visible = false
			if Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
			elif Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
			elif not target1.dead:
				newtarget = move_arrow(arrow1, 1)
			elif not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
			elif not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
		4:
			arrow4.visible = false
			if Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
			elif not target1.dead:
				newtarget = move_arrow(arrow1, 1)
			elif not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
			elif not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
			elif Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
		5:
			arrow5.visible = false
			if not target1.dead:
				newtarget = move_arrow(arrow1, 1)
			elif not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
			elif not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
			elif Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
			elif Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
	return newtarget

func move_arrow_up(Holyactive, target1, target2, target3, target4, target5, arrow1, arrow2, arrow3, arrow4, arrow5, target, enemylist):
	var newtarget
	match target:
		1:
			arrow1.visible = false
			if Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
			elif Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
			elif not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
			elif not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
			elif not target1.dead:
				newtarget = move_arrow(arrow1, 1)
		2:
			arrow2.visible = false
			if not target1.dead:
				newtarget = move_arrow(arrow1, 1)
			elif Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
			elif Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
			elif not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
			elif not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
				
		3:
			arrow3.visible = false
			if not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
			elif not target1.dead:
				newtarget = move_arrow(arrow1, 1)
			elif Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
			elif Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
			elif not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
		4:
			arrow4.visible = false
			if not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
			elif not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
			elif not target1.dead:
				newtarget = move_arrow(arrow1, 1)
			elif Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
			elif Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
		5:
			arrow5.visible = false
			if Holyactive and not target4.dead:
				newtarget = move_arrow(arrow4, 4)
			elif not target3.dead and target3 in enemylist:
				newtarget = move_arrow(arrow3, 3)
			elif not target2.dead and target2 in enemylist:
				newtarget = move_arrow(arrow2, 2)
			elif not target1.dead:
				newtarget = move_arrow(arrow1, 1)
			elif Holyactive and not target5.dead:
				newtarget = move_arrow(arrow5, 5)
	return newtarget

func move_arrow(newarrow, newtarget):
	newarrow.visible = true
	return newtarget
