extends Control

signal play_again()

onready var scores := $CenterContainer/VBoxContainer/Scores
onready var total_score := $CenterContainer/VBoxContainer/Scores/TotalScore

onready var show_tween := $ShowTween
onready var hide_tween := $HideTween

func show():
	.show()
	for child in scores.get_children():
		child.show()
		
	total_score.text = "Final Score: %s" % ScoreManager.score
	show_tween.start()


func hide():
	if visible:
		hide_tween.start()


func _on_HideTween_tween_all_completed():
	.hide()


func _on_Retry_pressed():
	emit_signal("play_again")
