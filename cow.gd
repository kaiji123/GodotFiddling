extends Node2D

var falling = false
@onready var player = $"../player"
# Called when the node enters the scene tree for the first time.
func _ready():
	print("hello")
func _process(delta):
	if falling == true:
		position.y = position.y + 2* delta

# Called every frame. 'delta' is the elapsed time since the previous frame.

# Called when a body enters the area.
func _on_area_2d_body_entered(body):
	print("Entered")
	print(body)
	if body == player:
	
		# Move the node down
		falling = true
