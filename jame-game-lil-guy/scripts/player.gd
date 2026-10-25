extends CharacterBody2D

@export var speed: float = 300
@export var gravity: float = 30
@export var jump_force: float = 300
var counter: int = 0
@onready var sprite: Sprite2D = $Sprite2D
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
@onready var original_sprite_scale: Vector2 = sprite.scale
@onready var original_box_size: Vector2 = collision_shape.shape.size
var valence: int = 2

func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 1000:
			velocity.y = 1000
	if Input.is_action_just_pressed("jump") && is_on_floor():
		
		velocity.y = -900
	
	if Input.is_action_just_pressed("shrink_toggle"):
		counter += 1
		if counter % 2 == 1:
			var target_sprite_scale: Vector2 = original_sprite_scale * 0.5
			
			if sprite.scale.x <= target_sprite_scale.x:
				return
			
			var tween: Tween = create_tween().set_parallel(true)
		
			
			tween.tween_property(sprite, "scale", target_sprite_scale, 0.25)\
				.set_trans(Tween.TRANS_QUAD)\
				.set_ease(Tween.EASE_OUT)
			
			
			var box_shape: RectangleShape2D = collision_shape.shape
			var target_box_size: Vector2 = original_box_size * 0.5
			
			
			tween.tween_property(box_shape, "size", target_box_size, 0.25)\
				.set_trans(Tween.TRANS_QUAD)\
				.set_ease(Tween.EASE_OUT)
			
		else:
			var target_sprite_scale: Vector2 = original_sprite_scale 
			
			if sprite.scale.x >= target_sprite_scale.x:
				return
			
			var tween: Tween = create_tween().set_parallel(true)
		
			
			tween.tween_property(sprite, "scale", target_sprite_scale, 0.25)\
				.set_trans(Tween.TRANS_QUAD)\
				.set_ease(Tween.EASE_OUT)
			
			
			var box_shape: RectangleShape2D = collision_shape.shape
			var target_box_size: Vector2 = original_box_size 
			
			
			tween.tween_property(box_shape, "size", target_box_size, 0.25)\
				.set_trans(Tween.TRANS_QUAD)\
				.set_ease(Tween.EASE_OUT)
	
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	velocity.x += 70 * horizontal_direction
	velocity.x *= 0.9
	
	
	move_and_slide()
	
	
	print(velocity)


signal score_changed(new_score: int)
var score: int = 0

func add_score(amount: int) -> void:
		score += amount
		score_changed.emit(score)
	
