@tool
extends FluentGenerator
class_name TopBarGenerator

func view() -> CustomControl:
	return hbox().align(BOX_A_CENTER).anchors(TOP_WIDE).embed(CustomUnrelatedControl.new()).named("TopBarButtons").embed(button().text("Some Button").named("SomeButton").script_path("res://example/generated/some_other_generated_button.gd").hook(_on_pressed, "pressed"))
	
func _on_pressed() -> void:
	print(" Some Button has been pressed!")

func export_path() -> String:
	return "res://example/generated/top_bar"
