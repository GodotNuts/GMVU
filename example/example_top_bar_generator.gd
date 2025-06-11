@tool
extends FluentGenerator
class_name TopBarGenerator

func view() -> CustomControl:
	return hbox().align(BOX_A_CENTER).anchors(TOP_WIDE).embed(CustomUnrelatedControl.new()).embed(button().text("Some Button").named("SomeButton"))

func export_path() -> String:
	return "res://example/top_bar"
	
func _on_pressed() -> void:
	print(" Some Button has been pressed!")
