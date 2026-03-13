extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer # Player of animations

# ------ PLAY ANIM ------
# Function to play animations
func play_anim(animname): animation_player.play(animname)

# ------ STOP ANIM ------
# Function to stop animations
func stop_anim(): animation_player.stop()
