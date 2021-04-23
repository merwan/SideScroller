extends KinematicBody2D

const SPEED = 700
const GRAVITY = 2000
const JUMP_FORCE = -1000
const FLOOR_NORMAL = Vector2(0, -1)

var motion = Vector2()

func walk():
	if Input.is_action_pressed("ui_right"):
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = false
		motion.x = SPEED
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite.play("walk")
		$AnimatedSprite.flip_h = true
		motion.x = -SPEED
	else:
		$AnimatedSprite.play("idle")
		motion.x = 0

func gravity(delta):
	if is_on_floor():
		motion.y = 0
	else:
		motion.y += GRAVITY * delta

func jump():
	if is_on_floor() and Input.is_action_pressed("jump"):
		motion.y = JUMP_FORCE
	if motion.y < 0:
		$AnimatedSprite.play("jump")

func _physics_process(delta):
	walk()
	gravity(delta)
	jump()
	move_and_slide(motion, FLOOR_NORMAL)
