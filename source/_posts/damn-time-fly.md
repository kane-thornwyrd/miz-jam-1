---
title: 'Damn Time fly  '
date: 2020-08-18 19:07:35
tags:
	- Start
	- Launch
	- Reflection
	- Gameplay
	- Code
	- GDScript
	- Strategy
---

## Brainmelting (like a Brainstorm, but inside a food processor)
Well, I started something like 2~3 days ago, and I forgot to prep my devlog !
So, I'm trying to make amend for this by writing this ;)

I dug in old tutorials I love, to get some inspiration, I think I'll go for a simple platformer, but something is tickling my mind…
I want to add some graphic violence and gore to spice up the merry and cute art.

I must admit, I have something like _Carrion_ in mind, but I don't want to just rippoff…
But I want the "_get inside peoples, exit their body while making their head explode with a fountain of blood_"-type of experience, with a lot of smiles and cute music and child laughters…

Or maybe something like the "Waters of Mars" episode of Doctor Who, but less "zombie" and more willy-nilly "Oh I'm infected, oh nevermind, let's meet all my co-workers"…

## Technical stuffs
I'll take something like the "single source of truth" path in my code, making a huge `Dictionary` containing about anything that the game require, like inputs, collider's states, etc.

Here's an example of the `input_state.gd`:

```gdscript
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
```

Also, I'm trying to implement something like the raycast utility from Game Endeavor using the `get_world_2d().direct_space_state.intersect_ray` method…
