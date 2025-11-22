class_name Deck extends Node2D

#region

## CONSTANT VARIABLES ##
const CARD_SCENE_PATH = "res://scenes/card.tscn"
const CARD_DRAW_SPEED : float = 0.4

@onready var card_manager : CardManager = $"../card_manager"
@onready var player_hand : PlayerHand = $"../player_hand"
@onready var sprite : Sprite2D = $Sprite2D
@onready var collision_shape : CollisionShape2D = $Area2D/CollisionShape2D
@onready var cards_left_label : RichTextLabel = $cards_left_label

## STANDARD VARIABLES ##
var player_deck : Array = ["Bonbon Hero", "Bonbon Hero", "Bonbon Hero"]
#endregion

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cards_left_label.text = str(player_deck.size())
	print($Area2D.collision_mask)
	pass # Replace with function body.


func draw_card(): 
	var card_drawn = player_deck[0]
	player_deck.erase( card_drawn )
	
	#If player drew the last card in the deck, disable the deck
	if player_deck.size() == 0 :
		collision_shape.disabled = true
		sprite.visible = false
		cards_left_label.visible = false
	
	print("Player drew a card")
	cards_left_label.text = str(player_deck.size())
	var card_scene = preload( CARD_SCENE_PATH )
	var new_card = card_scene.instantiate()
	card_manager.add_child( new_card )
	new_card.name = "Card"
	player_hand.add_card_to_hand( new_card, CARD_DRAW_SPEED )
