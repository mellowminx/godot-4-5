# useful for 2D games where there are a lot of clickable game objects that often change position
# for example, a game where you can click and drag to move decorations around

# script to manually sort child nodes (their order in the node tree) based on y-sort
# used to correct mouse input propagation following y-sort
# reorders children nodes based on y position

# using built-in y-sort feature only sorts nodes' z-index visually, but mouse input propagation still follows node tree order
# this is because mouse input (hover, click) still follows node tree order
# so if there are lots of clickable game objects using y-sort, it can be unintuitive to click on them because the object shown on top
# (highest z-index via y-sort) is not necessarily the one at the bottom of the node order, so the mouse input will still be detected by
# whichever node is highest in the tree order

# in my setup, the parent node still has "z as relative" and "y sort enabled" checked. child nodes have only "z as relative" checked.
# I call this function whenever a clickable game object changes position
# the parent node should be provided in the parameter
# sorting will be done on all nodes that have a "position" property
# early return if there's only 1 child node

func reorder_children_y(parent) -> void:
	var children_draft : Array = parent.get_children()
	if children_draft.size() <= 1:
		return
	var children : Array = []
	for i in children_draft:
		if "position" in i:
			children.append(i)
	children.sort_custom(func(a, b): return a.position.y < b.position.y)
	for i in range(children.size()):
		parent.move_child(children[i], i)
