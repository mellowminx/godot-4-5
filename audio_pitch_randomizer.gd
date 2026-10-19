# used to make sound effects less monotonous by randomizing sound file and pitch scale

extends AudioStreamPlayer2D

@export var sounds : Array[AudioStream]
@export var pitch_min : float = 0.8
@export var pitch_max : float = 1.3

@export var fade_out_if_too_many_plays : bool = false
var fade_timer = null
var fade_enabled : bool = false
@export var fade_timer_wait_time : float = 3.5

@onready var saved_volume_db : float = volume_db

func _ready() -> void:
	if not fade_out_if_too_many_plays:
		return
	# create a timer if fade is on
	fade_timer = Timer.new()
	add_child(fade_timer)
	fade_timer.wait_time = fade_timer_wait_time
	fade_timer.one_shot = true
	fade_timer.timeout.connect(on_fade_timer_timeout)

func play_sound() -> void:
	if sounds.size() > 1:
		sounds.shuffle()
	stream = sounds[0]
	pitch_scale = randf_range(pitch_min,pitch_max)
  # option to use pitch scale based on semitone adjustment
	# pitch_scale = get_adjusted_pitch_scale()
	play()
	check_for_fade()

func check_for_fade() -> void:
	if not fade_out_if_too_many_plays:
		return
	if not fade_timer:
		return
	if fade_timer.is_stopped():
		fade_timer.start()
	# reduces volume every time sound is played
	#saved_volume_db = volume_db
	volume_db -= 1.0

func on_fade_timer_timeout() -> void:
	# restore normal volume
	volume_db = saved_volume_db

### OPTION TO ADJUST PITCH SCALE BASED ON SEMITONES
func get_adjusted_pitch_scale() -> float:
	# major pentatonic
	#var _semitone_change: float = [0,2,4,7,9].pick_random()
	# major
	var _semitone_change: float = [0, 2, 4, 5, 7, 9, 11].pick_random()
	# minor
	#var _semitone_change: float = [0, 2, 3, 5, 7, 8, 10].pick_random()
	#_semitone_change += [0,12].pick_random()
	var _pitch_scale : float = pow(2.0, _semitone_change/12.0)
	#print_debug(_pitch_scale)
	return _pitch_scale
