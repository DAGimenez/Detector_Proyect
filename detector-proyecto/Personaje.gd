extends CharacterBody2D


var SPEED = 300.0



func _physics_process(delta: float) -> void:
	# Add the gravity.
	
		velocity.y =0 # la velocidad incial del personaje es 0
		var direction := Vector2.ZERO
		if Input.is_action_pressed( "vi_left"):
			direction.x -= 1
		if Input.is_action_pressed("vi_right"):
			direction.x += 1
		if Input.is_action_pressed("vi_up"):
			direction.y -=1
		if Input.is_action_pressed("vi_down"):
			direction.y += 1
		if Input.is_action_just_pressed("vi_shift"):
			SPEED= 400.0
		if Input.is_action_just_released ("vi_shift"):
			SPEED= 300.0
		


#con esto normalizamos la velocidad en diagonal
		if direction.length()> 0:
			direction= direction.normalized()
		velocity=direction *	SPEED


		move_and_slide()
