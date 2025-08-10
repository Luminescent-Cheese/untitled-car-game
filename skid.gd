extends Line2D

var on = false
func _process(delta: float) -> void:
	if on:
		remove_point(0)
	if get_point_count() == 0:
		queue_free()
func _on_timer_timeout() -> void:
	on = true
