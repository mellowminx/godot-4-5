extends Polygon2D

# Make mouse_passthrough_polygon functional by dyamically updating polygon points based on global position and window size/scale
# Attach this script to the Polygon2D that will be used as the mouse_passthrough_polygon

# source:
# https://www.youtube.com/watch?v=13loqUeIFNQ
# https://github.com/aimforbigfoot/NAD-LAB-Godot-Projects-4.0/blob/main/movingwindow-interactable/src/world.gd

# Modified above code to make it work with window resizing / window height width override
# Still does not work with node scale / resize

func _physics_process(delta: float) -> void:
	get_window().mouse_passthrough = false
	get_window().mouse_passthrough_polygon = getPolygon()

func getPolygon() -> PackedVector2Array:
	var window_scale = get_window().get_screen_transform().get_scale()
	var a := []
	for point in self.polygon:
		a.append((point * window_scale) + (self.global_position * window_scale))
	var pv2a := PackedVector2Array(a)
	return pv2a
