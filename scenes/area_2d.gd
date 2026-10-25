extends Area2D

@export var value_amount: int = 1

func _ready() -> void:
	# Connect Godot's built-in body_entered signal to this script
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("add_score"):
		body.add_score(value_amount)
		queue_free() 
