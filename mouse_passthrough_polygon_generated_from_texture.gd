extends Polygon2D

# Dynamically generate polygon from texture and use in mouse_passthrough_polygon
# Make mouse_passthrough_polygon functional by dyamically updating polygon points based on global position and window size/scale

# Attach this script to the Polygon2D that will be used as the mouse_passthrough_polygon
# Reference a texture

# Modified from https://github.com/mellowminx/godot-4-5/blob/main/mouse_passthrough_polygon.gd and https://github.com/mellowminx/godot-4-5/blob/main/generate_button_click_mask_from_button_normal_texture.gd

# Works with window resizing / window height width override
# Still does not work with node scale / resize

# reference a texture here
# for ex. @onready var my_texture = $TextureButton.texture_normal
@onready var my_texture

var generated_polygon

func _ready() -> void:
	# Get the image from the texture
	var image = my_texture.get_image()
	# Create the BitMap
	var bitmap = BitMap.new()
	# Fill it from the image alpha
	bitmap.create_from_image_alpha(image)
	# Create polygon
	var polygon_from_bitmap = bitmap.opaque_to_polygons(Rect2(Vector2(), image.get_size()))
	generated_polygon = polygon_from_bitmap[0]
  # The Polygon2D node to which this script is attached will have its polygon replaced with this dynamically generated one
	polygon = generated_polygon

func _physics_process(delta: float) -> void:
	get_window().mouse_passthrough = false
	get_window().mouse_passthrough_polygon = getPolygon()

func getPolygon() -> PackedVector2Array:
	var window_scale = get_window().get_screen_transform().get_scale()
	# still trying to get node_scale to work so haven't used it yet!
	var node_scale = global_transform.get_scale()
	var final_scale = window_scale
	var texture_half_size = my_texture.get_size()/2
	var a := []
	for point in polygon:
		a.append((point * final_scale) + ((global_position - texture_half_size) * final_scale))
	var pv2a := PackedVector2Array(a)
	return pv2a

# optional - draw polygon
#func _on_draw() -> void:
	#draw_polyline(getPolygon(), Color.AQUA)
