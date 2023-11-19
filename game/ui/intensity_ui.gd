class_name IntensityUI extends PanelContainer

## User interface that switches between song intensity levels.
## The intensity_changed signal is emitted when the user selects an intensity
## options.  The intensity amount, a float between 0 and 1, is sent with the
## signal.

## The intensity value is emitted when the UI intensity is changed.
signal intensity_changed(intensity: float)

signal play_mode_changed(play_mode: PlayMode)

## UI intensity options
enum Intensity {
	LOW,
	MEDIUM,
	HIGH,
	THIRTY,
	SIXTY
}

# Requests that the current selected song be played at 30 or 60 second
# loop mode instead of the intensity scale.
enum PlayMode {
	THIRTY,
	SIXTY
}

# The UI for song selections and intensity control.
@onready var _low_intensity: CheckButton = %LowIntensity
@onready var _medium_intensity: CheckButton = %MediumIntensity
@onready var _high_intensity: CheckButton = %HighIntensity
@onready var _thirty_seconds: CheckButton = %ThirtySeconds
@onready var _sixty_seconds: CheckButton = %SixtySeconds


var _intensity_level: Intensity:
	set(value):
		if(value != _intensity_level):
			_intensity_level = value
			match _intensity_level:
				Intensity.LOW:
					_intensity_value = INTENSITY_LOW
				Intensity.MEDIUM:
					_intensity_value = INTENSITY_MEDIUM
				Intensity.HIGH:
					_intensity_value = INTENSITY_HIGH


var _intensity_value: float:
	set(value):
		if(value != _intensity_value):
			_intensity_value = value


var disabled: bool = true:
	set(value):
		if value != disabled:
			disabled = value

			_low_intensity.disabled = disabled
			_medium_intensity.disabled = disabled
			_high_intensity.disabled = disabled
			_thirty_seconds.disabled = disabled
			_sixty_seconds.disabled = disabled

			if(!disabled and !_intensity_level):
				# set the first time intensity level
				set_intensity_ui(Intensity.LOW)


## Fixed float values for _intensity_value
const INTENSITY_LOW: float = 0.0
const INTENSITY_MEDIUM: float = 0.5
const INTENSITY_HIGH: float = 1.0
const INTENSITY_THIRTY: float = 1.0
const INTENSITY_SIXTY: float = 1.0


## Set the UI toggle switch for the required intensity.
## This will generate the intensity_changed signal carrying
## the appropriate intensity float value.
func set_intensity_ui(value: Intensity) -> void:
	match value:
		Intensity.LOW:
			_low_intensity.set_pressed(true)
			_medium_intensity.set_pressed_no_signal(false)
			_high_intensity.set_pressed_no_signal(false)
			_thirty_seconds.set_pressed_no_signal(false)
			_sixty_seconds.set_pressed_no_signal(false)
		Intensity.MEDIUM:
			_low_intensity.set_pressed_no_signal(false)
			_medium_intensity.set_pressed(true)
			_high_intensity.set_pressed_no_signal(false)
			_thirty_seconds.set_pressed_no_signal(false)
			_sixty_seconds.set_pressed_no_signal(false)
		Intensity.HIGH:
			_low_intensity.set_pressed_no_signal(false)
			_medium_intensity.set_pressed_no_signal(false)
			_high_intensity.set_pressed(true)
			_thirty_seconds.set_pressed_no_signal(false)
			_sixty_seconds.set_pressed_no_signal(false)
		Intensity.THIRTY:
			_low_intensity.set_pressed_no_signal(false)
			_medium_intensity.set_pressed_no_signal(false)
			_high_intensity.set_pressed(false)
			_thirty_seconds.set_pressed_no_signal(true)
			_sixty_seconds.set_pressed_no_signal(false)
		Intensity.SIXTY:
			_low_intensity.set_pressed_no_signal(false)
			_medium_intensity.set_pressed_no_signal(false)
			_high_intensity.set_pressed(false)
			_thirty_seconds.set_pressed_no_signal(false)
			_sixty_seconds.set_pressed_no_signal(true)

	_intensity_level = value


func _on_low_intensity_toggled(button_pressed: bool) -> void:
	if button_pressed and _intensity_level != Intensity.LOW:
		_intensity_level = Intensity.LOW
		intensity_changed.emit(_intensity_value)


func _on_medium_intensity_toggled(button_pressed: bool) -> void:
	if button_pressed and _intensity_level != Intensity.MEDIUM:
		_intensity_level = Intensity.MEDIUM
		intensity_changed.emit(_intensity_value)


func _on_high_intensity_toggled(button_pressed: bool) -> void:
	if button_pressed and _intensity_level != Intensity.HIGH:
		_intensity_level = Intensity.HIGH
		intensity_changed.emit(_intensity_value)


func _on_thirty_seconds_toggled(button_pressed: bool) -> void:
	if button_pressed and _intensity_level != Intensity.THIRTY:
		_intensity_level = Intensity.THIRTY
		play_mode_changed.emit(PlayMode.THIRTY)


func _on_sixty_seconds_toggled(button_pressed: bool) -> void:
	if button_pressed and _intensity_level != Intensity.SIXTY:
		_intensity_level = Intensity.SIXTY
		play_mode_changed.emit(PlayMode.SIXTY)
