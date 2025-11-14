extends TextureButton

# from https://www.reddit.com/r/godot/comments/1cdgtdl/how_to_use_a_click_mask_for_texture_button/
# note - somehow this only works inside the script directly attached to the button
# does not seem to work as custom class inheriting from texturebutton, does not work as function in autoload global script
# does not work as static function... at least for my use case with transparent clickable windows

# optional for debugging click mask: add a Sprite2D child node to the button to display the click mask
# @export var bitmap_sprite : Sprite2D

func _ready() -> void:
	# use button's normal texture to generate click mask
	generate_texture_from_click_mask(texture_normal)

func generate_texture_from_click_mask(_texture) -> void:
	# make sure button has a texture
	if _texture: 
		# Get the image from the texture normal
		var image = _texture.get_image()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_click_mask = bitmap
