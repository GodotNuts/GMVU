extends VBoxContainer

func _ready() -> void:
	animate_player_input()


func animate_player_input() -> void:
	var tween = create_tween()
	tween.set_ease(Tween.EaseType.EASE_IN_OUT)
	tween.set_trans(Tween.TransitionType.TRANS_LINEAR)
	tween.tween_property(%PlayerNameInput, "position", get("position") + Vector2(20, 20), 1.0)



