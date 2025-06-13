# Copyright (c) 2025-present Diurnal Productions, LLC
@tool
extends FluentGenerator
class_name MainMenuGenerator

const MENU_BUTTONS = [null, { name = "GoButton", text = "Go!" }, null, { name = "BackButton", text = "Back" }, null]

func view() -> CustomControl:
	return control().named("UI").anchors(FULL_RECT).script_path("res://example/main_menu.gd").embed(TopBarGenerator.new()).children([
		vbox().named("MenuItems").align(BOX_A_CENTER).grow_h(GROW_BOTH).anchors(CENTER).children([
			label("Player Name:"),
			line_edit().named("PlayerNameInput").placeholder_text("Player name").h_size(SHRINK_CENTER).min_size(200, 20).script_path("res://example/player_name_input.gd"),
			vbox().named("Buttons").v_size(SHRINK_BEGIN).align(BOX_A_BEGIN).min_size(100, 120).script_path("res://example/generated/button_menu.gd").hook(_some_signal_fired, "%BackButton.some_signal").children([
				for_each(MENU_BUTTONS,
					func(_idx, val):
						return (button()
								.add_variable("is_showing", TYPE_BOOL, true)
								.add_signal("some_signal", ["to_print"])
								.hook(_on_button_pressed, "pressed")
								.script_path("res://example/generated/generated_button.gd")
								.named(val.name).unique(true)
								.text(val.text)
								.hook(_some_signal_fired, "some_signal")
								.h_align(HORIZONTAL_ALIGNMENT_CENTER)
								.h_size(SHRINK_CENTER)) if val else spacer(.1))
			])
		])
	])

func export_path() -> String:
	return "res://example/main_menu"
	
func _on_button_pressed() -> void:
	raw_code("pressed").disconnect(_on_button_pressed)
	raw_code("is_showing = false")
	raw_code("some_signal").emit("Some signal fired!")

func _some_signal_fired(to_print: String) -> void:
	print(to_print)

#func function(value: String):
	#return value
	#
#func signal_ref(value: String):
	#return value
