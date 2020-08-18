extends Node

var current: Dictionary
var _key_actions: Dictionary


func _init() -> void:
	for action in InputMap.get_actions():
		current[action] = false
		for input_keys in InputMap.get_action_list(action):
			_key_actions[input_keys.as_text()] = action


func _unhandled_input(event: InputEvent) -> void:
	# FIXME May cause issue with UI, we'll see later…
	get_tree().set_input_as_handled()
	if _key_actions.has(event.as_text()):
		current[_key_actions[event.as_text()]] = event.is_pressed()
