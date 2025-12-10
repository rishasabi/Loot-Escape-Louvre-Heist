extends CharacterBody2D

@export var speed := 120

var direction := Vector2.ZERO

func _physics_process(delta):
	direction = Vector2.ZERO

	# Movement Inputs
	if Input.is_action_pressed("ui_up"):
		direction.y = -1
	if Input.is_action_pressed("ui_down"):
		direction.y = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_right"):
		direction.x = 1

	# Normalize diagonal movement
	velocity = direction.normalized() * speed

	move_and_slide()

	_update_animation()
func _update_animation():
	var anim: AnimatedSprite2D = $AnimatedSprite2D

	if direction == Vector2.ZERO:
		# Idle animations based on current walking animation
		if anim.animation.ends_with("up"):
			anim.animation = "idle_up"
		elif anim.animation.ends_with("down"):
			anim.animation = "idle_down"
		elif anim.animation.ends_with("left"):
			anim.animation = "idle_left"
		elif anim.animation.ends_with("right"):
			anim.animation = "idle_right"
		anim.play()
		return

	# Walking animations
	if direction.x > 0:
		anim.animation = "walk_right"
	elif direction.x < 0:
		anim.animation = "walk_left"

	if direction.y > 0:
		anim.animation = "walk_down"
	elif direction.y < 0:
		anim.animation = "walk_up"

	anim.play()
