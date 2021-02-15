extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed : int = 200
export var timeToRun : int = 100

var NB_MAX_WALK : int = 50

var nb_walk : int = 0
var direction : int = 0
var runTime : int = 0

var sweetObject


# Called when the node enters the scene tree for the first time.
func _ready():
	sweetObject = load("res://src/Objects/Sweet.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if nb_walk != NB_MAX_WALK:
		var collision = move_and_collide(get_velocity() * delta)
		if collision:
			direction = (direction + 1) % 4
		nb_walk += 1
	else:
		direction = randi() % 4
		nb_walk = 0
	
	if runTime > 0:
		runTime -= 1
		if runTime % 15 == 0:
			var newSweet = sweetObject.instance() as Sweet
			newSweet.value = 1
			add_child(newSweet)
			newSweet.set_as_toplevel(true)
			newSweet.global_position = global_position
	else:
		speed = 200

func get_velocity():
	var velocity = Vector2()  # The player's movement vector.
	if direction == 0:
		velocity.x += 1
	if direction == 1:
		velocity.x -= 1
	if direction == 2:
		velocity.y += 1
	if direction == 3:
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	return velocity

func _on_Area2D_body_entered(body):
	print(body.name)
	var new_direction = body.position - position
	if new_direction.x < 0:
		direction = 1
	else:
		direction = 0
	speed = 600
	runTime = timeToRun

