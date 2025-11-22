extends Node2D

var random_value = 1
@onready var dice_sprite: Sprite2D = $Sprite2D

func dice() -> void :
	randomize()
	random_value = int(randf_range(0, 6))
	print(random_value)
	pass

func _input( event : InputEvent ) -> void:
	if event.is_action_pressed("roll") :
		dice()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if random_value == 1 :
		dice_sprite.frame = 0
	if random_value == 2 : 
		dice_sprite.frame = 1
	if random_value == 3 : 
		dice_sprite.frame = 2
	if random_value == 4 : 
		dice_sprite.frame = 3
	if random_value == 5 : 
		dice_sprite.frame = 4
	if random_value == 6 : 
		dice_sprite.frame = 5
	pass
