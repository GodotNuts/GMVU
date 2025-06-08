@tool
extends FluentGenerator

func view() -> CustomControl:
	return control().named("UI").anchors([0, 1, 1, 0]).children([
		vbox().named("MenuItems").align(BOX_A_CENTER).grow_h(Control.GrowDirection.GROW_DIRECTION_BOTH).anchors(VCENTER_WIDE).children([
			label("Player Name:"),
			line_edit().named("PlayerNameInput").placeholder_text("Player name").h_size(SHRINK_CENTER).min_size(200, 20),
			hbox().align(BOX_A_CENTER).children([
				control().h_size(EXPAND_FILL),
				button().named("GoButton").unique(true).text("Go!").h_align(HORIZONTAL_ALIGNMENT_CENTER).h_size(SHRINK_CENTER),
				control().h_size(EXPAND_FILL),
			])
		])
	])

func export_path() -> String:
	return "res://generated_views/main_menu"
