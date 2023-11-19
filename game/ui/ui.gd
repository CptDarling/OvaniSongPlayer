class_name UI extends Control

@onready var intensity_ui: IntensityUI = %IntensityUI

signal song_selected(ovani_song: OvaniSong)
signal intensity_changed(intensity: float)
signal play_mode_changed(play_mode)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset()


## Reset the UI to default control selections.
func reset() -> void:
	disable_controls(true)


func disable_controls(value: bool) -> void:
	intensity_ui.disabled = value


func _on_tree_play_song(ovani_song) -> void:
	if ovani_song:
		if ovani_song.SongMode == OvaniSong.OvaniMode.Intensities:
			intensity_ui.disabled = false
		else:
			intensity_ui.disabled = true

		intensity_ui.set_intensity_ui(IntensityUI.Intensity.LOW)
		song_selected.emit(ovani_song)


func _on_intensity_ui_intensity_changed(intensity: float) -> void:
	# re-emit the signal.
	intensity_changed.emit(intensity)


func _on_intensity_ui_play_mode_changed(play_mode) -> void:
	# re-emit the signal.
	play_mode_changed.emit(play_mode)
