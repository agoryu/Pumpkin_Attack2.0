extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var scoreLable : Label = $Label
onready var scene : = get_tree()
onready var overlay : ColorRect = $PauseOverlay

var paused : bool = false setget set_paused

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		self.paused = not paused
		scene.set_input_as_handled()

func set_paused(value : bool):
	paused = value
	scene.paused = value
	overlay.visible = value

# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.connect("score_updated", self, "update_score")

func update_score():
	scoreLable.text = "Score: %s" % GameData.score

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
