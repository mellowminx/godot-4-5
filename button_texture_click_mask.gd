extends TextureButton

# Attach to button that has a normal texture image, which shall be used as its click mask

# source:
# https://www.reddit.com/r/godot/comments/1cdgtdl/how_to_use_a_click_mask_for_texture_button/

if texture_normal:
		# Get the image from the texture normal
		var image = texture_normal.get_image()
		# Create the BitMap
		var bitmap = BitMap.new()
		# Fill it from the image alpha
		bitmap.create_from_image_alpha(image)
		# Assign it to the mask
		texture_click_mask = bitmap
