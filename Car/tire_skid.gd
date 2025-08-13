extends Node2D

@onready var skid = preload("res://Car/skid.tscn")
var on: bool = false
var currentLine: Line2D = null

func _physics_process(delta: float) -> void:
	if get_parent().get_parent().currentSpeed > 700 and Input.get_axis("left","right") != 0:
		if currentLine == null:
			currentLine = skid.instantiate()
			currentLine.default_color = Color.BLACK
			currentLine.width == 10
			$Line2D.add_child(currentLine)
			currentLine.add_point(global_position)
			currentLine.top_level  = true
			currentLine.z_index = get_parent().z_index - 1
		else:
			currentLine.add_point((global_position))
	else:
		currentLine = null
