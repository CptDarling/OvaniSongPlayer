@tool
class_name BuildFileTree extends Tree

const root_folder = "res://OvaniMusic"

signal song_selected(ovani_song: OvaniSong)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_build_tree()


func _build_tree() -> void:
	prints("root_folder:", root_folder)

	var directory_names: PackedStringArray = DirAccess.get_directories_at(root_folder)
	prints("directory_names:", directory_names)
	var root: TreeItem = create_item()

	for folder in directory_names:
		prints("folder:", folder)
		var child1: TreeItem = create_item(root)
		child1.set_text(0, folder)

		var sub_path: String = "/".join([root_folder, folder])
		prints("sub_path:", sub_path)
		for sub_folder in DirAccess.get_directories_at(sub_path):
			var res_path = sub_path + "/" + sub_folder
			prints("res_path:", res_path)
			var resource_names: PackedStringArray = DirAccess.get_files_at(res_path)
			for res in map_tres(resource_names):
				var full_path = res_path + "/" + res
				prints("full_path:", full_path)
				var child2 = create_item(child1)
				child2.set_metadata(0, full_path)
				child2.set_text(0, res.split(".")[0])


func map_tres(arr: PackedStringArray) -> PackedStringArray:
	var resp: PackedStringArray = []
	for filename in arr:
		if filename.ends_with(".tres"):
			resp.push_back(filename)
		elif filename.ends_with(".tres.remap"):
			filename = ".".join(filename.split(".").slice(0, -1))
			resp.push_back(filename)
		prints("filename:", filename)
	return resp


func _on_item_selected() -> void:
	var song_path = get_selected().get_metadata(0)
	if song_path:
		var song: OvaniSong = load(song_path)
		prints("song:", song)
		if song:
			song_selected.emit(song)
