extends Area2D

# In the Inspector you'll see "game_node_path" where you can drag your Game node.
@export var game_node_path: NodePath
# This variable is set up to find the Game Node using the path you set in the Inspector.
@onready var game_node = get_node_or_null(game_node_path)

var inside: bool = false
var body_p: Node2D = null

func _ready():
	# optional: ensure signals are connected if not already connected in the editor
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))
	if not is_connected("body_exited", Callable(self, "_on_body_exited")):
		connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body: Node2D) -> void:
	inside = true
	body_p = body

func _on_body_exited(body: Node2D) -> void:
	if body == body_p:
		inside = false
		body_p = null

func _physics_process(delta: float) -> void:
	if inside and Input.is_action_just_pressed("teleport"):
		# Check if the body is in the "player" group
		if body_p and body_p.is_in_group("player"):
			
			# ⭐ 1. DEDUCT 45 SECONDS FROM THE GAME TIMER: ⭐
			# It calls the 'reduce_time' function in the game.gd script
			if game_node:
				game_node.reduce_time(45) # The variable name matches!
			else:
				push_warning("Teleport: game_node_path is not set. Drag your Game node into the teleport's 'game_node_path' property in the Inspector.")
			
			# 2. Teleport the player
			body_p.global_position = $Destination.global_position
