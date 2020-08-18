extends Node

const UNIT_SIZE:int = 16

var RNG:RandomNumberGenerator

export var screensize:Vector2 = Vector2(ProjectSettings.get_setting("display/window/size/width"), ProjectSettings.get_setting("display/window/size/height"))

func _ready():
  RNG = RandomNumberGenerator.new()
  RNG.set_seed(51981581861161858146614864681618)
