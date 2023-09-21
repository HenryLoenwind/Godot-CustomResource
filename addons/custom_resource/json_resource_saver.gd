@tool
extends ResourceFormatSaver
class_name JsonResourceSaver

const _JSONResource = preload("res://addons/custom_resource/json_resource.gd")

func _get_recognized_extensions(resource: Resource):
	return ["json", "jdat"]


func _recognize(resource: Resource) -> bool:
	# Cast instead of using "is" keyword in case is a subclass
	resource = resource as _JSONResource

	if resource:
		return true

	return false


func _save(resource: Resource, path: String, flags: int) -> Error:
	var err:int
	var file = FileAccess.open(path, FileAccess.WRITE)

	if err != OK:
		printerr('Can\'t write file: "%s"! code: %d.' % [path, err])
		return err

	file.store_string(JSON.stringify(resource.get("_data")))
	file.close()
	return OK
