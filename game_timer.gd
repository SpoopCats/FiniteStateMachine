extends Node2D


@onready var timer_label: Label = $TimerLabel
@onready var timer: Timer = $Timer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_running_out(timer.time_left)
	timer_label.text = format_seconds_to_string(timer.time_left)

# pulled this from my 2DSurvivor course tutorial
# function to just make the numbers in the countdown easy to read
func format_seconds_to_string(seconds: float):
	var minutes = floor(seconds / 60) # if less than 60 sec it will go to 0 because it rounds down to nearest int
	var remaining_seconds = seconds - (minutes * 60)
	# we use a format string below to get the leading zero with the number of seconds is less than 10
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))

# changes colour of timer to notify player that time is running out
func time_running_out(time_left):
	if time_left > 61:
		pass
	if time_left < 61 and time_left > 11:
		# translating hex color f98284 to RGBA --> https://rgbacolorpicker.com/hex-to-rgba
		# divide values by max value of 255 to get a value b/w 0.0 and 1.0
		# e.g., red 249 / 255 = 0.97
		timer_label.add_theme_color_override("font_color", Color(0.97, 0.50, 0.52, 1))
	if time_left <= 11:
		# this red isn't currently in the color palette
		timer_label.add_theme_color_override("font_color", Color.TOMATO)
