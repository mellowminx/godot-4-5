extends TextureButton

# from https://www.reddit.com/r/godot/comments/1cdgtdl/how_to_use_a_click_mask_for_texture_button/
# note - somehow this only works inside the script directly attached to the button
# does not seem to work as custom class inheriting from texturebutton, does not work as function in autoload global script
# does not work as static function... at least for my use case with transparent clickable windows

# variant of https://github.com/mellowminx/godot-4-5/blob/main/generate_button_click_mask_from_button_normal_texture.gd
# for my specific use case - use parent Sprite2D node's texture
@export var sprite : Sprite2D

# optional for debugging click mask: add a Sprite2D child node to the button to display the click mask
# @export var bitmap_sprite : Sprite2D

func _ready() -> void:
	# use parent Sprite2D's texture to generate click mask
	generate_texture_from_click_mask(sprite.texture)

func generate_texture_from_click_mask(_texture) -> void:
	# make sure texture exists
	if _texture: 
		# Get the image from the texture
		var image = _texture.get_image()
		# in my use case I check if the parent Sprite2D's texture is flipped, if yes I follow it
		# Check if it should flip_h (sometimes, idk why, it has to be if NOT sprite.flip_h)
		if sprite.flip_h:
			image.flip_x()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_click_mask = bitmap
		var image_size = image.get_size()
		# in my use case since I use a parent Sprite2D's texture I have to fix the position
		# Fix the offset
		position = -(image_size/2)
		# (optional) For debugging, assign it to the child Sprite2D node to display click mask bitmap
		#var bitmap_image = bitmap.convert_to_image()
		#var bitmap_texture = ImageTexture.create_from_image(bitmap_image)
		#bitmap_sprite.texture = bitmap_texture
		#bitmap_sprite.position = position
