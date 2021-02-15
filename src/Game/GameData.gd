extends Node

signal score_updated

var score : int = 0 setget set_score

func _ready():
	self.set_score(score)

func set_score(value : int):
	score = value
	emit_signal("score_updated")
