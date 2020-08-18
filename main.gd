extends Node2D

onready var cursor: Node2D = $CursorCanvas/Cursor


func _init() -> void:
	# Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass


func _ready():
	$Camera2D/CanvasLayer/ColorRect.set_size(get_viewport_rect().size + Vector2(40,40))
	$Camera2D.target = $Player
	self.set_camera_limits()


func _process(_delta: float) -> void:
	# cursor.position = get_local_mouse_position()
	$Camera2D/CanvasLayer/ColorRect.set_position(get_viewport_rect().position - Vector2(0, $Camera2D/CanvasLayer/ColorRect.get_size().y / 2))


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == 1:
			cursor.state = cursor.State.PRESSED if event.pressed else cursor.State.NORMAL


func set_camera_limits():
	var map_limits = $TileMap.get_used_rect()
	var map_cellsize = $TileMap.cell_size
	$Camera2D.limit_left = map_limits.position.x * map_cellsize.x
	$Camera2D.limit_right = map_limits.end.x * map_cellsize.x
	$Camera2D.limit_top = map_limits.position.y * map_cellsize.y
	$Camera2D.limit_bottom = map_limits.end.y * map_cellsize.y
