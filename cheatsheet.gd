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

enum State { IDLE, WALK, RUN, JUMP }
var current_state: State = State.IDLE

# note - enums are not saved in json and must be converted back to enum when loading saved data
# for ex.
enum Fruit { APPLE, ORANGE, BANANA }
func get_save_data() -> Dictionary:
  var data: Dictionary
  data = {"collected_fruits": [Fruit.APPLE, Fruit.Orange]}
  return data
# in json, data gets saved as:
# {"collected_fruits": ["0", "1"]}
func load_save_data(data: Dictionary) -> void:
  var converted_data: Dictionary
  for fruit in data["collected_fruits"]:
    converted_data["collected_fruits"].append(int(fruit) as Fruit)

@export var sprite_node: Sprite2D
# require export node to be assigned in inspector
func _ready() -> void:
  assert(sprite_node != null, "ERROR: assign sprite_node export in inspector")

# placeholder text (useful for translations)
text = ("out of %s" % "food") # "out of food"
text = ("%s is %s" % ["apple", "red"]) # "apple is red"
text = ("{fruit} is {color}").format({fruit = "apple", color = "red"}) # apple is red

# get readable variable type
var sometext: String = "Hello"
type_string(typeof(sometext))
# String
# useful for data validation
# note that for json data validation, json turns int data into float data
# so int and float should be considered equivalent for json data validation

# file save dialog
var dialog = SAVE_FILE_DIALOG.instantiate()
dialog.data = _data
# set default filename BEFORE adding child / node ready
dialog.get_line_edit().text = _data["default_file_base_name"]
GLOBAL.world.add_child(dialog)
