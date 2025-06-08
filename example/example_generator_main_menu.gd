# Copyright (c) 2025-present Diurnal Productions, LLC
@tool
extends FluentGenerator

func view() -> CustomControl:
	return control().named("UI").anchors(FULL_RECT).script_path("res://example/main_menu.gd").children([
		vbox().named("MenuItems").align(BOX_A_CENTER).grow_h(GROW_BOTH).anchors(VCENTER_WIDE).children([
			label("Player Name:"),
			line_edit().named("PlayerNameInput").placeholder_text("Player name").h_size(SHRINK_CENTER).min_size(200, 20).script_path("res://example/player_name_input.gd"),
			hbox().align(BOX_A_CENTER).children([
				control().h_size(EXPAND_FILL),
				button().named("GoButton").unique(true).text("Go!").h_align(HORIZONTAL_ALIGNMENT_CENTER).h_size(SHRINK_CENTER),
				control().h_size(EXPAND_FILL),
			])
		])
	])

func export_path() -> String:
	return "res://example/main_menu"
