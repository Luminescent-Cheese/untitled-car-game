extends Node2D
#turns headlights in direction car is turning
@onready var leftHeadlight = $LightOccluder2D
@onready var rightHeadlight = $LightOccluder2D2

func _physics_process(delta: float) -> void:
	var headlightTween = get_tree().create_tween()
	headlightTween.set_parallel(true)
	if Input.is_action_pressed("left"):
		headlightTween.tween_property(leftHeadlight,"rotation",deg_to_rad(-10), .2)
		headlightTween.tween_property(rightHeadlight,"rotation",deg_to_rad(170), .2)
	elif Input.is_action_pressed("right"):
		headlightTween.tween_property(leftHeadlight,"rotation",deg_to_rad(10), .2)
		headlightTween.tween_property(rightHeadlight,"rotation",deg_to_rad(190), .2)
	else:
		headlightTween.tween_property(leftHeadlight,"rotation",0, .2)
		headlightTween.tween_property(rightHeadlight,"rotation",deg_to_rad(180), .2)

#Makes Headlights blink when hitting a wall
func _on_right_headlight_hit_box_body_entered(body: Node2D) -> void:
	if get_parent().currentSpeed > 800:
		$RightHeadLightBlinkAnimation.play("RightHeadLightBlink")

func _on_left_headlight_hix_box_body_entered(body: Node2D) -> void:
	if get_parent().currentSpeed > 800:
		$LeftHeadLightBlinkAnimation.play("LeftHeadLightBlink")
