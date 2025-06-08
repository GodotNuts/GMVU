# Copyright (c) 2025-present Diurnal Productions, LLC
extends Control

func _ready() -> void:
	%GoButton.pressed.connect(_on_go_pressed)

func _on_go_pressed() -> void:
	print("Alright already, I'm going, I'm going!")
