# Just my personal cheat sheet
# Code I use often but always forget how to write

await get_tree().create_timer(1.0).timeout

await RenderingServer.frame_post_draw

# needs stored variable reference to node
is_instance_valid(instance)
instance.is_queued_for_deletion()

@export var array_of_images: Array[CompressedTexture2D]

@export_enum("apple", "orange", "banana") var fruit := "apple"

enum State { IDLE, WALK, RUN, JUMP }
var current_state: State = State.IDLE
