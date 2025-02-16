extends CharacterBody2D
@onready var animation_tree: AnimationTree = $AnimationTree


var attack : bool

const SPEED : float = 300.0

var last_action : String = "idle"

func _physics_process(delta: float) -> void:
	if velocity == Vector2.ZERO:
		update_animation_parameters("idle")
	elif Input.is_action_just_pressed("attack_key") and velocity == Vector2.ZERO:
		update_animation_parameters("attack")
	else:
		update_animation_parameters("walking")
	
	var direction_x := Input.get_axis("left", "right")
	
	
	if direction_x > 0:
		$Sprite2D.scale.x = -1
	elif direction_x < 0:
		$Sprite2D.scale.x = 1
	
	var direction_y := Input.get_axis("up", "down")

	if direction_x:
		velocity.x = direction_x * SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y,0,SPEED)
	
	move_and_slide()

func new_action() -> void:
	if Input.is_action_just_pressed("attack_key"):
		attack = true


func update_animation_parameters(action : String) -> void:
	if (action != last_action):
		animation_tree["parameters/conditions/" + last_action] = false
		animation_tree["parameters/conditions/" + action] = true
		last_action = action
