extends CharacterBody2D
#Atributes
@export var maxSpeed: int = 1500
@export var acceleration: int = 10
@export var friction: int = 5

#speed that vechicle turns at different speeds
@export var steeringCurve: Curve

var goalRotation = 0
@export var currentSpeed: int = 0
var currentMovementDirection = Vector2.ZERO


func _physics_process(delta: float) -> void:
	#handles Rotation
	if Input.is_action_pressed("left"):
		if abs(currentSpeed) > 0:
			goalRotation -= steeringCurve.sample_baked(currentSpeed)
		if currentSpeed > 1000:
			currentSpeed -= 5
	if Input.is_action_pressed("right"):
		if abs(currentSpeed) > 0:
			goalRotation += steeringCurve.sample_baked(currentSpeed)
		if currentSpeed > 1000:
			currentSpeed -= 5
	var rotateTween = get_tree().create_tween()
	rotateTween.tween_property(self, "rotation", goalRotation, 0.5) 
	
	if Input.is_action_pressed("accelerate"):
		if currentSpeed < maxSpeed:
			currentSpeed += acceleration
	elif Input.is_action_pressed("reverse"):
		if currentSpeed > (0-maxSpeed/2):
			currentSpeed -= acceleration
	else:
		#Apply friction
		if abs(currentSpeed) < 20:
			currentSpeed = 0
		if currentSpeed > 0:
			if Input.get_axis("left","right") == 0:
				currentSpeed -= friction 
			else:
				currentSpeed -= friction * 1.2
		elif currentSpeed < 0:
			if Input.get_axis("left","right") == 0:
				currentSpeed += friction 
			else:
				currentSpeed += friction * 1.2
	
	var rotationInVector2 = Vector2.from_angle(rotation)
	currentMovementDirection = currentMovementDirection.lerp(rotationInVector2, .1)
	velocity = currentMovementDirection * currentSpeed
	move_and_slide()
