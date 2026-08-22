# Just my personal cheat sheet
# Code I use often but always forget how to write

await get_tree().create_timer(1.0).timeout

await RenderingServer.frame_post_draw

# can await signals
# usually need a child node to wait for parent / scene root to be ready (child nodes are ready before parents)
# replace get_parent() with stable reference like export var
await get_parent().ready

# needs stored variable reference to node
is_instance_valid(instance)
instance.is_queued_for_deletion()

@export var array_of_images: Array[CompressedTexture2D]

@export_enum("apple", "orange", "banana") var fruit := "apple"

@export var sprite_node: Sprite2D
# require export node to be assigned in inspector
func _ready() -> void:
  assert(sprite_node != null, "ERROR: assign sprite_node export in inspector")

enum State { IDLE, WALK, RUN, JUMP }
var current_state: State = State.IDLE

# placeholder text (useful for translations)
text = ("out of %s" % "food") # "out of food"
text = ("%s is %s" % ["apple", "red"]) # "apple is red"
text = ("{fruit} is {color}").format({fruit = "apple", color = "red"}) # apple is red
