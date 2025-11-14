extends CollisionPolygon2D

# check if mouse click inside polygon shape
# useful when you can't use "mouse_entered" / "mouse_exited"
# for ex. with a touchscreen (phone/tablet) where you tap on a point and need to know if it's inside an area or not; no cursor to enter/exit the area
# useful when area2D shape is a polygon, not a rect (there are easier solutions for rect shapes)
# note that mouse activity still gets interference from other nodes that have mouse filter set to STOP/PASS, so this is NOT a solution for having translucent overlapping clickable objects

# reference polygon node
# can be Polygon2D or CollisionPolygon2D
var polygon_node = self

# get mouse click global position
func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			is_in_polygon(polygon_node,get_global_mouse_position())

func is_in_polygon(_polygon_node,click_pos) -> bool:
	# get polygon vertices from polygon node
	var polygon = _polygon_node.get_polygon()
	# get global position of polygon node
	var polygon_global_pos = _polygon_node.global_position
	# prepare new array for converted polygon vertices
	var global_polygon = []
	# convert vertices' positions to global positions
	for vertice in polygon:
		vertice += polygon_global_pos
		# place in new array
		global_polygon.append(vertice)
	# global_polygon = new array with vertices' global positions
	# check if mouse click global position is inside the polygon
	var polygon_result = Geometry2D.is_point_in_polygon(click_pos,global_polygon)
	# (optional for debugging) print result
	prints("clicked inside polygon? ",polygon_result)
	# return true/false answer for "clicked inside polygon?"
	return polygon_result
