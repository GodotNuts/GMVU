extends Button

signal some_signal(to_print)

var is_showing: bool = true

func _ready() -> void:
	pressed.connect(_on_button_pressed)
	some_signal.connect(_some_signal_fired)


func _on_button_pressed() -> void:
	pressed.disconnect(_on_button_pressed)
	is_showing = false
	some_signal.emit("Some signal fired!")


func _some_signal_fired(to_print: String) -> void:
	print(to_print)




