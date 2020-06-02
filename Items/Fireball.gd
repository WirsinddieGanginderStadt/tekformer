"""
	FIREBALL.GD
	@auth jm
"""
extends Area2D

const SPEED = 1000 # speed of the fireball
var velocity = Vector2() #you can only shoot the fireball 
var direction = 1 #variable for the direction of the player


func set_fireball_direction(dir): #direction of the fireball
	direction = dir
	if dir == -1:
		$AnimatedSprite.flip_h = true

func _physics_process(delta: float) -> void: #handles the physic process of the fireball
	velocity.x = SPEED * delta * direction #speed of the fireball
	translate(velocity)
	$AnimatedSprite.play("shoot") #animation of the player 



func _on_VisibilityNotifier2D_screen_exited() -> void: #if the fireball leaves the screen he gots deleted
	queue_free() #deletes the fireball


func _on_Fireball_body_entered(body: Node) -> void: #if the fireball enters the enemy he got killed
	if "Slime" in body.name:
		body.dead()
	queue_free()
	
