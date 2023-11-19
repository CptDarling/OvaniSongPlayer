class_name GameUI extends Node

## This is an example project for the OvaniPlayer plugin.

@onready var ui: UI = $UI

var _current_song: OvaniSong

func _on_ui_song_selected(ovani_song: OvaniSong) -> void:
	_current_song = ovani_song
	_current_song.SongMode = OvaniSong.OvaniMode.Intensities
	MusicManager.play_song(_current_song)


func _on_ui_intensity_changed(intensity: float) -> void:
	MusicManager.fade_intensity(intensity)


func _on_ui_play_mode_changed(play_mode) -> void:
	pass # Replace with function body.
	if _current_song:
		match play_mode:
			IntensityUI.PlayMode.THIRTY:
				_current_song.SongMode = OvaniSong.OvaniMode.Loop30

			IntensityUI.PlayMode.SIXTY:
				_current_song.SongMode = OvaniSong.OvaniMode.Loop60

		MusicManager.play_song(_current_song)
