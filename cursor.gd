extends Node2D

const _CURSOR_POSITIONS = [
	Vector2(560, 160),
	Vector2(592, 160)
]

enum State {NORMAL, PRESSED}

export(State) var state = State.NORMAL setget set_state

onready var visual = $Visual

func set_state(new_state):
	visual.get_texture().region.position = _CURSOR_POSITIONS[new_state]
	state = new_state
