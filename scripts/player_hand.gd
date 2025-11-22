class_name PlayerHand extends Node2D

#region

## CONSTANTS ##
#const HAND_COUNT : int = 5
const CARD_WIDTH : int = 200
const HAND_Y_POSITION : int = 920
const DEFAULT_CARD_MOVE_SPEED = 0.1 

## ON READY VARIABLES ##
@onready var card_manager: CardManager = $"../card_manager"

## STANDARD VARIABLES ##
var player_hand : Array = []
var center_screen_x 
#endregion


func _ready() -> void:
	center_screen_x = get_viewport().size.x / 2


func add_card_to_hand( card, speed ) :
	if card not in player_hand :
		player_hand.insert( 0,  card )
		update_hand_positions( speed )
	else : 
		animate_card_to_position( card , card.position_in_hand, DEFAULT_CARD_MOVE_SPEED )

func update_hand_positions( speed ) :
	for i in range( player_hand.size() ) :
		# Get new card position based on index passed through.
		var new_position = Vector2(calculate_card_position( i ), HAND_Y_POSITION)
		var card = player_hand[i]
		card.position_in_hand = new_position
		animate_card_to_position( card, new_position, speed )
	pass 


func calculate_card_position( index ) :
	var x_offset = (player_hand.size() -1) * CARD_WIDTH
	var x_position = center_screen_x + index * CARD_WIDTH - x_offset / 2
	return x_position


func animate_card_to_position( card, new_position, speed ) :
	var tween = get_tree().create_tween()
	tween.tween_property( card, "position", new_position, speed )
	pass

func remove_card_from_hand( card ) :
	if card in player_hand :
		player_hand.erase( card )
		update_hand_positions( DEFAULT_CARD_MOVE_SPEED )
	pass
