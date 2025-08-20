extends CharacterBody2D
#behavior variables:
var maxSpeed = 1000
var acceleration = 10
var friction = 5
@export var steeringCurve: Curve

var currentSpeed = 0
var goalRotation = 0
var currentMovementDirection = Vector2.ZERO

func get_information(playerPosition):
	#Gets the inputs that the enemy should be doing
	#wantedInputs stores the inputs we send to movementcode index 0 = right, 2 = left, 3 = accelerate, 4 = decelerate
	var wantedInputs = [0,0,1,0]
	var angleToPlayer = (global_position.direction_to(playerPosition)).angle()
	var neededRotation = angleToPlayer - rotation
	if abs(neededRotation) > 0.5:
		if neededRotation >= 0:
			wantedInputs[0] = 1
		elif neededRotation < 0:
			wantedInputs[1] = 1
	return wantedInputs

func _physics_process(delta: float) -> void:
	var InputList = get_information($"../Car".global_position)
	if InputList[1] == 1:
		#right
		if abs(currentSpeed) > 0:
			goalRotation -= steeringCurve.sample_baked(currentSpeed)
		if currentSpeed > 1000:
			currentSpeed -= 5
	if InputList[0] == 1:
		#left
		if abs(currentSpeed) > 0:
			goalRotation += steeringCurve.sample_baked(currentSpeed)
		if currentSpeed > 1000:
			currentSpeed -= 5
	var rotateTween = get_tree().create_tween()
	rotateTween.tween_property(self, "rotation", goalRotation, 0.5) 
	
	if InputList[2] == 1:
		if currentSpeed < maxSpeed:
			currentSpeed += acceleration
	elif InputList[3] == 1:
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
