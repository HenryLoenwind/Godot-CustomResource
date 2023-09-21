@tool
extends ResourceFormatLoader
class_name JSONResourceLoader

const _JSONResource = preload("res://addons/custom_resource/json_resource.gd")

func _get_recognized_extensions():
	return ["json", "jdat"]


func _get_resource_type(path: String) -> String:
	var ext = path.get_extension().to_lower()
	if ext == "json" or ext == "jdat":
		return "Resource"
	return ""


func _handles_type(typename) -> bool:
	# I'll give you a hand for custom resources... use this snipet and that's it ;)
	return ClassDB.is_parent_class(typename, "Resource")


func _load(path: String, original_path: String, use_sub_threads, cache_mode):
	var json = JSON.new()
	var json_error := json.parse(FileAccess.get_file_as_string(path))

	if json_error:
		push_error("Failed parsing JSON file: [%s at line %s]" % [json.get_error_message(), json.get_error_line()])
		return json_error

	var res := _JSONResource.new()
	res.set_data(json.data)

	# Everything went well, and you parsed your file data into your resource. Life is good, return it
	return res
