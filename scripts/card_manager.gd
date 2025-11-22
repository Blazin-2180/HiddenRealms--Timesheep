class_name CardManager extends Node2D

#region

## CONSTANT VARIABLES ##
const COLLISION_MASK_CARD = 1
const COLLISION_MASK_CARD_SLOT = 2

## STANDARD VARIABLES ##
var screen_size 
var card_being_dragged 
var is_hovering_on_card : bool

#endregion


func _ready() -> void:
	screen_size = get_viewport_rect().size
	pass 
	
	
func _process(_delta: float) -> void:
	if card_being_dragged :
		var mouse_position = get_global_mouse_position()
		card_being_dragged.position = Vector2( clamp( mouse_position.x, 0, screen_size.x ), 
			clamp( mouse_position.y, 0, screen_size.y ) )
	pass


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT :
		if event.is_pressed() :
			var card = raycast_check_for_card() 
			if card :
				start_drag( card )
		else : 
			if card_being_dragged :
				finish_drag()


func start_drag( card ) :
	card_being_dragged = card
	card.scale = Vector2( 1, 1 )
	pass


func finish_drag() :
	card_being_dragged.scale = Vector2( 1.05, 1.05 )
	var card_slot_found = raycast_check_for_card_slot()
	if card_slot_found && !card_slot_found.card_in_slot :
		#card dropped into an empty card slot
		card_being_dragged.position = card_slot_found.position
		card_being_dragged.get_node("Area2D/CollisionShape2D").disabled = true
		card_slot_found.card_in_slot = true
	card_being_dragged = null
	pass


func connect_card_signals( card ) -> void :
	card.connect("card_hovered", on_hovered_over_card)
	card.connect("card_unhovered", on_hovered_left_card)


func on_hovered_over_card( card ) -> void :
	if !is_hovering_on_card :
		is_hovering_on_card = true
		highlight_card(card, true)
	print("hovered")
	pass


func on_hovered_left_card( card ) -> void :
	if !card_being_dragged :
		# If not dragging
		highlight_card(card, false)
			# Check if hovered off card straight onto another card
		var new_card_hovered = raycast_check_for_card()
		if new_card_hovered :
			highlight_card(new_card_hovered, true )
		else : 
			is_hovering_on_card = false
		print("unhovered")
		pass

func highlight_card( card, hovered : bool) -> void :
	if hovered :
		card.z_index = 2
	else :
		card.scale = Vector2( 1, 1 )
		card.z_index = 1
	pass


func raycast_check_for_card_slot() :
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD_SLOT
	var result = space_state.intersect_point( parameters )
	if result.size() > 0 :
		return result[0].collider.get_parent()
		#return result[0].collider.get_parent()
		#print(result)
	return null
	

func raycast_check_for_card() :
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point( parameters )
	if result.size() > 0 :
		return get_card_with_highest_z_index(result)
		#return result[0].collider.get_parent()
		#print(result)
	return null

func get_card_with_highest_z_index( cards ) :
	#Assume the first card in cards has the highest index
	var highest_z_card = cards[0].collider.get_parent()
	var highest_z_index = highest_z_card.z_index
	
	# Loop through the rest of the cards for higher z_indexes
	for i in range( 1, cards.size()) :
		var current_card = cards[i].collider.get_parent()
		if current_card.z_index > highest_z_index :
			highest_z_card = current_card
			highest_z_index = current_card.z_index
	return highest_z_card
