extends Node2D

var id = []
var selected = false #Keeps user from grabbing entire deck all at once

	
func _on_Button_pressed():
	if Solitaire.cardHold == [] and selected == false:
		selected = true
		Solitaire.cardHold = id
		z_index = 1
	elif Solitaire.cardHold != [] and selected == true:
		selected = false
		Solitaire.cardHold = []
		z_index = 0
		print(id)
		
func _physics_process(delta):
	if selected and Solitaire.cardHold != []:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)


func _on_Area2D_area_entered(area):
	if Solitaire.cardHold != [] and selected == true:
		if Solitaire.cardHold[1] < id[1]+1:
			print(str(Solitaire.cardHold[1]))
			print(str(id[1]))
