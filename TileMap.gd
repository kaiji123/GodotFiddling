extends TileMap



@onready var player = $"../player"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called when a physics body enters a physics area.
func _on_TileMap_body_entered(body):
	if body == player:
	if body == player:
		# Get the position of the tile under the player
		var player_position = player.global_position
		var tile_map_position = world_to_map(player_position)
		var tile_id = get_cellv(tile_map_position)
		
		# Check if the tile exists and is not empty
		if tile_id != -1:
			# Remove the tile
			set_cellv(tile_map_position, -1)
