class_name GameUI extends Node

## This is an example project for the OvaniPlayer plugin.

@onready var ovani_player: OvaniPlayer = $OvaniPlayer
@onready var ui: UI = $UI

var _intense: bool = false

const FADE_SECONDS: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
#	ovani_player.FadeVolume(-40, 0.1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if(Input.is_action_just_pressed("ToggleIntensity")):
		_intense = not _intense
		if(_intense):
			print("ToggleIntensity pressed: on")
			ovani_player.FadeIntensity(1, FADE_SECONDS)
		else:
			print("ToggleIntensity pressed: off")
			ovani_player.FadeIntensity(0, FADE_SECONDS)


func _play_song(ovani_song: OvaniSong, transition_time: float) -> void:
	ovani_player.PlaySongNow(ovani_song, transition_time)


func _on_ui_song_selected(ovani_song: OvaniSong) -> void:
	if ovani_player.QueuedSongs.size() > 0:
		var current: OvaniSong = ovani_player.QueuedSongs[0]
		if(ovani_song != current):
			_play_song(ovani_song, 1.0)
	else:
		_play_song(ovani_song, 0.0)


func _on_ui_intensity_changed(value: float) -> void:
	prints("song intensity:", value)
	if ovani_player:
		if ovani_player.QueuedSongs.size() > 0:
			ovani_player.FadeIntensity(value, FADE_SECONDS)
