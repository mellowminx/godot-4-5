extends TextureButton

func _ready() -> void:
  

func texture_changed() -> void:
	
	texture_normal = fish_sprite.texture
	
	if texture_normal:
		# Get the image from the texture normal
		var image = texture_normal.get_image()
		# Check if it should flip_h
		# not sure why this works in reverse but ok
		if not fish_sprite.flip_h:
			image.flip_x()
			#print("button click mask flipped")
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_click_mask = bitmap
		var image_size = image.get_size()
		# Fix the offset
		position = -(image_size/2)
		# For debugging, assign it to the bitmap sprite
		#var bitmap_image = bitmap.convert_to_image()
		#var bitmap_texture = ImageTexture.create_from_image(bitmap_image)
		#bitmap_sprite.texture = bitmap_texture
		#bitmap_sprite.position = position
