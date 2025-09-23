extends Polygon2D

# Dynamically generate polygon from texture and use in mouse_passthrough_polygon
# Make mouse_passthrough_polygon functional by dyamically updating polygon points based on global position and window size/scale
# Attach this script to the Polygon2D that will be used as the mouse_passthrough_polygon
# Reference a texture
# Modified from https://github.com/mellowminx/godot-4-5/blob/main/mouse_passthrough_polygon.gd and https://github.com/mellowminx/godot-4-5/blob/main/button_texture_click_mask.gd

# Works with window resizing / window height width override
# Still does not work with node scale / resize

# reference a texture here
# for ex. 
var my_texture

# get viewport width specified in project settings, this is "scale = 1" of the window
var initial_window_width: float

var generated_polygon

func _ready() -> void:
	initial_window_width = ProjectSettings.get_setting("display/window/size/viewport_width")

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
	polygon = dynamic_polygon

func _physics_process(delta: float) -> void:
	get_window().mouse_passthrough = false
	get_window().mouse_passthrough_polygon = getPolygon()

func getPolygon() -> PackedVector2Array:
	var window_scale = get_window().size.x / initial_window_width
	#var window_scale = 0.5
	#print(window_scale)
	#print(scale)
	var a := []
	for point in polygon:
		a.append((point * window_scale) + ((self.global_position - (my_texture.get_size()/2) * window_scale))
	var pv2a := PackedVector2Array(a)
	return pv2a










extends Polygon2D

#func _ready() -> void:
	#get_window().mouse_passthrough = false

@onready var fishbowl_button: TextureButton = $"../fishbowl-button"

var initial_window_width: float

var dynamic_polygon

func _ready() -> void:
	initial_window_width = ProjectSettings.get_setting("display/window/size/viewport_width")
	#print(scale)
	#print(get_parent().scale)
	#print(get_parent().get_parent().scale)
	
	# Get the image from the texture normal
	var image = fishbowl_button.texture_normal.get_image()
	# Create the BitMap
	var bitmap = BitMap.new()
	# Fill it from the image alpha
	bitmap.create_from_image_alpha(image)
	# Create polygon
	var polygon_from_bitmap = bitmap.opaque_to_polygons(Rect2(Vector2(), image.get_size()))
	dynamic_polygon = polygon_from_bitmap[0]
	polygon = dynamic_polygon

func _physics_process(delta: float) -> void:
	get_window().mouse_passthrough = false
	get_window().mouse_passthrough_polygon = getPolygon()
	#get_window().mouse_passthrough_polygon = polygon

# now works with window resize!
# does not work with node scale
func getPolygon() -> PackedVector2Array:
	var window_scale = get_window().size.x / initial_window_width
	#var window_scale = 0.5
	#print(window_scale)
	#print(scale)
	var a := []
	for point in polygon:
		a.append((point * window_scale) + ((self.global_position - (fishbowl_button.texture_normal.get_size()/2)) * window_scale))
	var pv2a := PackedVector2Array(a)
	return pv2a

func _on_draw() -> void:
	draw_polyline(getPolygon(), Color.AQUA)
