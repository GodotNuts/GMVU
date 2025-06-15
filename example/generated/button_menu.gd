extends VBoxContainer

func _ready() -> void:
	%BackButton.some_signal.connect(_some_signal_fired)


func _some_signal_fired(to_print: String) -> void:
	print(to_print)




