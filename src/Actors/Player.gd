extends KinematicBody2D

export var speed = 400

onready var attack : Node2D = $Attack
onready var animation : AnimationPlayer = $Attack/Animation

var oldMousePosition = Vector2.ZERO
var sweetValue

# Called when the node enters the scene tree for the first time.
func _ready():
	sweetValue = load("res://src/Objects/SweetValue.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = get_velocity()
	move_and_slide(velocity)
	#position += velocity * delta
	action_attack()
	
# Oriente attack of pumpkin
func action_attack():
	var joy_angle = Vector2.ZERO
	joy_angle.x = Input.get_joy_axis(0, JOY_AXIS_2)
	joy_angle.y = Input.get_joy_axis(0, JOY_AXIS_3)
	attack.rotation = joy_angle.angle()
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("attack"):
		animation.play("attack")
		
func get_velocity():
	var velocity = Vector2()  # The player's movement vector.
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	return velocity


func _on_AreaCollider_body_entered(body):
	if body is Sweet:
		body.queue_free()
		var sweetValueDisplay = sweetValue.instance() as SweetValue
		add_child(sweetValueDisplay)
		sweetValueDisplay.label.text = "+%s" % body.value
		sweetValueDisplay.set_as_toplevel(true)
		sweetValueDisplay.global_position = self.global_position
		sweetValueDisplay.animation.play("display")
		GameData.set_score(GameData.score + 1)
