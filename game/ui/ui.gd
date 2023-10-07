class_name UI extends Control

@onready var intensity_ui: IntensityUI = %IntensityUI

signal song_selected(ovani_song: OvaniSong)
signal intensity_changed(value: float)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()


## Reset the UI to default control selections.
func reset() -> void:
	disable_controls(true)


func disable_controls(value: bool) -> void:
	intensity_ui.disabled = value


func _on_tree_song_selected(ovani_song) -> void:
	if ovani_song:
		prints("song changed:", ovani_song)
		disable_controls(false)
		intensity_ui.set_intensity(IntensityUI.Intensity.LOW)
		song_selected.emit(ovani_song)


func _on_intensity_ui_intensity_changed(value) -> void:
	# re-emit the signal.
	intensity_changed.emit(value)
