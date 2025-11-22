class_name Deck extends Node2D

#region

## CONSTANT VARIABLES ##
const CARD_SCENE_PATH = "res://scenes/card.tscn"

@onready var card_manager: CardManager = $"../card_manager"
@onready var player_hand: PlayerHand = $"../player_hand"

## STANDARD VARIABLES ##
var player_deck : Array = ["Bonbon Hero", "Bonbon Hero", "Bonbon Hero"]
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print($Area2D.collision_mask)
	pass # Replace with function body.


func draw_card(): 
	print("Player drew a card")
	var card_scene = preload( CARD_SCENE_PATH )
	for i in range( player_deck.size() ) :
		var new_card = card_scene.instantiate()
		card_manager.add_child( new_card )
		new_card.name = "Card"
		player_hand.add_card_to_hand( new_card )
