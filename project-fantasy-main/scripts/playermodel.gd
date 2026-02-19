extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play_anim(animname):
	animation_player.play(animname)

func stop_anim():
	animation_player.stop()
