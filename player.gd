extends KinematicBody2D

const ORIGINAL_MOVE_SPEED:Vector2 = Vector2(0, 0)

var velocity:Vector2
var move_speed:Vector2 = ORIGINAL_MOVE_SPEED
var max_jump_velocity:float
var min_jump_velocity:float
var gravity:float
var unsticky_direction:Vector2 = Vector2.UP
var is_grounded:bool
var move_direction: Vector2
var ground_weight: float = 0.2
var air_weight: float = 0.1

var max_jump_height = 3.25 * Globals.UNIT_SIZE
var min_jump_height = 0.1 * Globals.UNIT_SIZE
var jump_duration = 0.6

var _is: InputState


func _ready() -> void:
	move_direction = Vector2(0.0,0.0)


func _init() -> void:
	_is = InputState.instance


func _physics_process(_delta: float) -> void:
	pass


func _process(_delta: float) -> void:
	pass


func _input(_event: InputEvent) -> void:
		pass


func _apply_gravity(_delta) -> void:
	gravity = 2 * max_jump_height / pow(jump_duration, 2)
	max_jump_velocity = -sqrt(2 * gravity * max_jump_height)
	min_jump_velocity = -sqrt(2 * gravity * min_jump_height)


func _apply_velocity(delta: float) -> void:
	self.velocity += self.unsticky_direction * -1 * self.gravity * delta

	var was_grounded = is_grounded
	is_grounded = is_on_floor()
	if was_grounded == null or is_grounded != was_grounded:
		emit_signal("grounded_updated", is_grounded)

	self.velocity.x = lerp(self.velocity.x, move_speed.x * move_direction.x, _get_h_weight())
	self.velocity.y = lerp(self.velocity.y, move_speed.y * move_direction.y, _get_h_weight())

	self.velocity = move_and_slide(self.velocity, unsticky_direction, true)
	if is_on_floor() and not (_is.current["ui_left"] or _is.current["ui_right"]):
		self.velocity.x = 0


func _get_h_weight():
	return self.ground_weight if $close_to_ground.is_colliding() else self.air_weight
