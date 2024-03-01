extends CharacterBody2D

const SPEED = 300.0
const MOVEMENT_SPEED = 10.0
const JUMP_VELOCITY = -400.0
const MAX_JUMP_COUNT = 2
@onready var nav_agent = $NavigationAgent2D
@onready var target = $"../player";
@onready var player  = $".";
@onready var anim_player  = $"./anime";
@onready var healthy = $HealthBar
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var jump_count = 0
var enemytimer = 0.0
var time_interval = 3.0  # Interval in seconds
@onready var health:float = 100:
	set(value):
		health = value

func _ready():
	healthy.init_health(100)
func _physics_process(delta):

	
	# Increment timer by delta time
	enemytimer += delta

	# Execute code every second
	if enemytimer >= time_interval:
		# Reset timer
		healthy.set_health(healthy.health - 10)
		enemytimer -= time_interval
	

	
	var direction = target.global_position - player.global_position
	if direction.x < 0:
		anim_player.play("idle_left")
		#print(player.rotation_degrees)
		#print("Direction is facing left")
	else:
		#anim_player.stop()
		anim_player.play("idle_right")
		

		look_at(target.global_position)
		player.rotation = clamp_angle(player.rotation, deg_to_rad(-60), deg_to_rad(-10))
		#print(rad_to_deg(player.rotation))

	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		nav_agent.target_position = target.global_position
		var next_nav_point = nav_agent.get_next_path_position()
		print('next nav', next_nav_point)
		var dir = next_nav_point - player.global_position
		print('direction', dir)
		
		
	
		velocity = dir * MOVEMENT_SPEED * delta
		
		#rotation.y = lerp_angle(rotation.y, atan2(-velocity.x, -velocity.z), delta * 10.0)
	move_and_slide()

	# Handle jump.
func clamp_angle(angle, min_angle, max_angle):
	# Ensure the angle is within the specified range
	if angle < min_angle:
		return min_angle
	elif angle > max_angle:
		return max_angle
	else:
		return angle
	


	

func _on_CharacterBody2D_body_shape_entered(body_id, body, body_shape, local_shape):
	
	if is_on_floor():
		jump_count = 0
