class_name IntensityUI extends PanelContainer

## User interface that switches between song intensity levels.
## The intensity_changed signal is emitted when the user selects an intensity
## options.  The intensity amount, a float between 0 and 1, is sent with the
## signal.

## The intensity value is emitted when the UI intensity is changed.
signal intensity_changed(value: float)

## UI intensity options
enum Intensity {
	LOW,
	MEDIUM,
	HIGH,
}

# The UI for song selections and intensity control.
@onready var _low_intensity: CheckButton = %LowIntensity
@onready var _medium_intensity: CheckButton = %MediumIntensity
@onready var _high_intensity: CheckButton = %HighIntensity

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
			intensity_changed.emit(_intensity_value)


var disabled: bool = true:
	set(value):
		if value != disabled:
			disabled = value
			_low_intensity.disabled = disabled
			_medium_intensity.disabled = disabled
			_high_intensity.disabled = disabled
			if(!disabled and !_intensity_level):
				# set the first time intensity level
				set_intensity(Intensity.LOW)


## Fixed float values for _intensity_value
const INTENSITY_LOW: float = 0.0
const INTENSITY_MEDIUM: float = 0.5
const INTENSITY_HIGH: float = 1.0


## Set the UI toggle switch for the required intensity.
## This will generate the intensity_changed signal carrying
## the appropriate intensity float value.
func set_intensity(value: Intensity) -> void:
	match value:
		Intensity.LOW:
			_low_intensity.set_pressed(true)
			_medium_intensity.set_pressed_no_signal(false)
			_high_intensity.set_pressed_no_signal(false)
		Intensity.MEDIUM:
			_low_intensity.set_pressed_no_signal(false)
			_medium_intensity.set_pressed(true)
			_high_intensity.set_pressed_no_signal(false)
		Intensity.HIGH:
			_low_intensity.set_pressed_no_signal(false)
			_medium_intensity.set_pressed_no_signal(false)
			_high_intensity.set_pressed(true)

	_intensity_level = value


func _on_low_intensity_toggled(button_pressed: bool) -> void:
	if button_pressed and _intensity_level != Intensity.LOW:
		_intensity_level = Intensity.LOW


func _on_medium_intensity_toggled(button_pressed: bool) -> void:
	if button_pressed and _intensity_level != Intensity.MEDIUM:
		_intensity_level = Intensity.MEDIUM


func _on_high_intensity_toggled(button_pressed: bool) -> void:
	if button_pressed and _intensity_level != Intensity.HIGH:
		_intensity_level = Intensity.HIGH
