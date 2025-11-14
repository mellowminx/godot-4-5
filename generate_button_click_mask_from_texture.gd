extends TextureButton

# from https://www.reddit.com/r/godot/comments/1cdgtdl/how_to_use_a_click_mask_for_texture_button/
# note - somehow this only works inside the script directly attached to the button
# does not seem to work as custom class inheriting from texturebutton, does not work as function in autoload global script
# does not work as static function... at least for my use case with transparent clickable windows

# optional for debugging click mask: add a Sprite2D child node to the button to display the click mask
# @export var bitmap_sprite : Sprite2D

func _ready() -> void:
	# use button's normal texture to generate click mask
	# (optional) in my own use case I use a parent Sprite2D node's texture for this
	generate_texture_from_click_mask(texture_normal)

func generate_texture_from_click_mask(_texture) -> void:
	# make sure button has a texture
	if _texture: 
		# Get the image from the texture normal
		var image = _texture.get_image()
		# (optional) in my use case I check if the parent Sprite2D's texture is flipped, if yes I follow it
		# (optional) Check if it should flip_h (optional 
		# if not fish_sprite.flip_h:
			#image.flip_x()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_click_mask = bitmap
		var image_size = image.get_size()
		# (optional) in my use case since I use a parent Sprite2D's texture I have to fix the position
		# (optional) Fix the offset
		# position = -(image_size/2)
		# (optional) For debugging, assign it to the child Sprite2D node to display click mask bitmap
		#var bitmap_image = bitmap.convert_to_image()
		#var bitmap_texture = ImageTexture.create_from_image(bitmap_image)
		#bitmap_sprite.texture = bitmap_texture
		#bitmap_sprite.position = position
