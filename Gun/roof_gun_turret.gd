extends CharacterBody2D

@onready var turretAnimation = $"../TurretAnimationPlayer"
@onready var bullet = preload("res://bullets/bullets.tscn")

func _physics_process(delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("fire gun"):
		turretAnimation.play("turret shot")
		
		
		
func _fire_bullet():
	var newbullet = bullet.instantiate()
	newbullet.direction = global_position.direction_to(get_global_mouse_position())
	newbullet.global_position = global_position
	get_parent().get_parent().get_parent().add_sibling(newbullet)
		
