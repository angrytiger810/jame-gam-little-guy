extends Label

@export var player: CharacterBody2D

func _ready() -> void:
	if player == null:
		print("ERROR: Player not assigned!")
		return

	player.score_changed.connect(_on_player_score_changed)
	_on_player_score_changed(player.score)

func _on_player_score_changed(new_score: int) -> void:
	text = "Electrons: " + str(new_score)
	print("Label updated: ", new_score)
