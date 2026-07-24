# used to correct mouse input propagation following y-sort
# reorder children based on y position
# used by fishbowl containers
func reorder_children_y(parent) -> void:
	var children_draft : Array = parent.get_children()
	if children_draft.size() <= 1:
		#print_debug("early return only 1 child")
		return
	var children : Array = []
	for i in children_draft:
		if "position" in i:
			children.append(i)
	children.sort_custom(func(a, b): return a.position.y < b.position.y)
	for i in range(children.size()):
		parent.move_child(children[i], i)
