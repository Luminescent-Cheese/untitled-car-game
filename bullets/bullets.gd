extends CharacterBody2D

@export var direction: Vector2

const SPEED = 3000

func _ready() -> void:
	look_at(get_global_mouse_position())
	direction = Vector2.from_angle(rotation)
func _physics_process(delta: float) -> void:
	velocity = direction * SPEED
	move_and_slide()


func _on_bullet_active_time_timeout() -> void:
	queue_free()
