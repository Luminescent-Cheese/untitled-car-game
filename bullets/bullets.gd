extends CharacterBody2D

@export var direction: Vector2

@export var SPEED = 7000

#Higher the number lower the accuracy. (degrees from mouse where it can be shot)
@export var ACCURACY = 0
var RNG: RandomNumberGenerator = RandomNumberGenerator.new()

func _ready() -> void:
	$CPUParticles2D.emitting = false
	look_at(get_global_mouse_position())
	var shotDirection = rad_to_deg(rotation) + RNG.randf_range(0-ACCURACY, ACCURACY)
	direction = Vector2.from_angle(deg_to_rad(shotDirection))
	visible = false
func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	move_and_slide()


func _on_bullet_active_time_timeout() -> void:
	queue_free()

func _on_seen_in_timer_timeout() -> void:
	visible = true


func _on_detect_collision_body_entered(body: Node2D) -> void:
	#plays an animation of sparks and than deletes bullet
	$bulletHitAnimation.play("bulletHit")

func speedToZero():
	SPEED = 0
