extends Node


func roomsInRoomDirectory(path):
	var files = []
	var dir = DirAccess.open(path)
	if dir:
		dir.open(path)
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if !dir.current_is_dir():
				files.append(path + file_name)
			file_name = dir.get_next()
	return files
