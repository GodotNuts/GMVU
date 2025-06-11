# Copyright (c) 2025-present Diurnal Productions, LLC
@tool
extends FluentGenerator

const MENU_BUTTONS = [null, { name = "GoButton", text = "Go!" }, null, { name = "BackButton", text = "Back" }, null]

func view() -> CustomControl:
	return control().named("UI").anchors(FULL_RECT).script_path("res://example/main_menu.gd").children([
		control(TopBarGenerator.new()),
		vbox().named("MenuItems").align(BOX_A_CENTER).grow_h(GROW_BOTH).anchors(CENTER).children([
			label("Player Name:"),
			line_edit().named("PlayerNameInput").placeholder_text("Player name").h_size(SHRINK_CENTER).min_size(200, 20).script_path("res://example/player_name_input.gd"),
			vbox().named("Buttons").v_size(SHRINK_BEGIN).align(BOX_A_BEGIN).min_size(100, 120).children([
				for_each(MENU_BUTTONS,
					func(_idx, val):
						return button().named(val.name).unique(true).text(val.text).h_align(HORIZONTAL_ALIGNMENT_CENTER).h_size(SHRINK_CENTER) if val else spacer(.1))
			])
		])
	])

func export_path() -> String:
	return "res://example/main_menu"
	
func _on_button_pressed() -> void:
	print("A button has been pressed!")
