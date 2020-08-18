tool
extends Node2D

class_name Raycaster

enum DIRECTIONS { UP, DOWN, LEFT, RIGHT }

export(DIRECTIONS) var _direction: int = DIRECTIONS.DOWN
export var _length: int = Globals.UNIT_SIZE

var _collision_shape_width: int
var _origins: PoolVector2Array = PoolVector2Array([])
var _targets: PoolVector2Array = PoolVector2Array([])


static func directions_to_vec2(dir: int) -> Vector2:
	return {
		DIRECTIONS.UP: Vector2.UP,
		DIRECTIONS.DOWN: Vector2.DOWN,
		DIRECTIONS.LEFT: Vector2.LEFT,
		DIRECTIONS.RIGHT: Vector2.RIGHT,
	}[dir]


static func vec2_to_directions(vec: Vector2) -> Vector2:
	return {
		Vector2.UP: DIRECTIONS.UP,
		Vector2.DOWN: DIRECTIONS.DOWN,
		Vector2.LEFT: DIRECTIONS.LEFT,
		Vector2.RIGHT: DIRECTIONS.RIGHT,
	}[vec]


func _ready() -> void:
	_update(DIRECTIONS.DOWN)


func _physics_process(_delta: float) -> void:
	# var space_state: Physics2DDirectSpaceState = get_world_2d().direct_space_state
	# var result: Dictionary = space_state.intersect_ray(Vector2(0, 0), Vector2(50, 100), [], 2147483647, false, true)
	pass


func _update(
		direction: int = _direction,
		length: int = _length
		) -> void:

	_direction = direction
	_length = length

	var _siblings: Array = get_parent().get_children()
	var _collision: CollisionShape2D

	for _sib in _siblings:
		if _sib is CollisionShape2D:
			assert(_sib.get_shape() is RectangleShape2D, "[Raycaster] CollisionShape2D: should be RectangleShape2D !")
			_collision = _sib
			break

	if _direction == DIRECTIONS.UP || _direction == DIRECTIONS.DOWN:
		_collision_shape_width = (_collision.get_shape().get_extents() * 2).x
	else:
		_collision_shape_width = (_collision.get_shape().get_extents() * 2).y

	if not _origins.empty():
		_origins = PoolVector2Array([])
	if not _targets.empty():
		_targets = PoolVector2Array([])

	var _origins_line: Vector2


	_set_visual_hints()


func _set_visual_hints() -> void:
	for _child in get_children() :
		_child.queue_free()
