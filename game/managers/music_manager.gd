extends Node

@onready var ovani_player: Node = %OvaniPlayer

const FADE_SECONDS: float = 2.0


func play_song(ovani_song: OvaniSong) -> void:
	if ovani_player.QueuedSongs.size() > 0:
		_play_song(ovani_song, 1.0)
	else:
		_play_song(ovani_song, 0.0)


func _play_song(ovani_song: OvaniSong, transition_time: float) -> void:
	ovani_player.PlaySongNow(ovani_song, transition_time)


func fade_intensity(value: float) -> void:
	if ovani_player.QueuedSongs.size() > 0:
		ovani_player.FadeIntensity(value, FADE_SECONDS)
