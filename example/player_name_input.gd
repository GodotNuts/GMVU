# Copyright (c) 2025-present Diurnal Productions, LLC
extends LineEdit

func _ready() -> void:
	text_changed.connect(_on_text_changed)

func _on_text_changed(new_text: String) -> void:
	print("New player name is: ", new_text)
