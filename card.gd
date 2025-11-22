extends Node2D

signal card_hovered
signal card_unhovered

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().connect_card_signals( self )
	# All cards must be a child of CardManager or this will error
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process( _delta: float) -> void:
	pass


func _on_area_2d_mouse_entered() -> void:
	card_hovered.emit( self )
	#emit_signal("card_hovered", self)
	pass 


func _on_area_2d_mouse_exited() -> void:
	card_unhovered.emit( self )
	#emit_signal("card_unhovered", self)
	pass 
