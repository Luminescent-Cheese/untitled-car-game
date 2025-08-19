extends CharacterBody2D

@export var direction: Vector2

const SPEED = 7000

func _ready() -> void:
	look_at(get_global_mouse_position())
	direction = Vector2.from_angle(rotation)
	visible = false
func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	move_and_slide()


func _on_bullet_active_time_timeout() -> void:
	queue_free()

func _on_seen_in_timer_timeout() -> void:
	visible = true


func _on_detect_collision_body_entered(body: Node2D) -> void:
	queue_free()
