extends RigidBody2D
# Ship

# tweek mass facter for modify ship control

export (Vector2) var MAX_VELOCITY = Vector2(200, 300)
export (int) var durability = 3

var thrust = Vector2(0, -1000)
var touque = 10000

var prev_global_position: Vector2 = Vector2.ZERO

onready var lt = $leftThuster
onready var rt = $rightThuster

onready var thuster_sfx = $ThursterSFX

func _ready() -> void:
    Global.ship = self


func _process(delta: float) -> void:
    $CanvasLayer/Label.text = String(durability)
    $CanvasLayer/Label2.text = String(linear_velocity)
    $CanvasLayer/Label3.text = String(angular_velocity)
    Global.constrain_in_screen(self, Vector2(16, 16))
    
    # clamping 
    durability = clamp(durability, 0, 3) # hard codded max durability
    
    if angular_velocity < -5:
        angular_velocity = -5
    elif angular_velocity > 5:
        angular_velocity = 5
    
    if linear_velocity.x < -MAX_VELOCITY.x:
        linear_velocity.x = -MAX_VELOCITY.x
    elif linear_velocity.x > MAX_VELOCITY.x:
        linear_velocity.x = MAX_VELOCITY.x
    
    if linear_velocity.y < -MAX_VELOCITY.y:
        linear_velocity.y = -MAX_VELOCITY.y
    elif linear_velocity.y > MAX_VELOCITY.y:
        linear_velocity.y = MAX_VELOCITY.y


func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
    if Input.is_action_pressed("w"):
        lt.emitting = true
        rt.emitting = true
        applied_force = thrust.rotated(rotation)
        
        if thuster_sfx.playing == false:
            thuster_sfx.play()
    elif Input.is_action_pressed("s"):
        applied_force = -(thrust / 2).rotated(rotation)
    else:
        lt.emitting = false
        rt.emitting = false
        applied_force = Vector2.ZERO
    
        thuster_sfx.stop()
        
    var rotation_dir = 0
    
    if Input.is_action_pressed("d"):
        rotation_dir += 1
    
    if Input.is_action_pressed("a"):
        rotation_dir -= 1
    
    applied_torque = rotation_dir * touque


# Barrier for ship to down side
func _on_PrevPositionAssigner_timeout() -> void:
    if linear_velocity.y < 0: # moving up
        prev_global_position.y = global_position.y + 200
        pass
    elif linear_velocity.y > 0: # moving down
        if global_position.y > prev_global_position.y:
            linear_velocity.y = 0


# collision with astroide
func _on_Ship_body_entered(_body: Node) -> void:
    if durability <= 0:
        queue_free()
        return
    
    durability -= 1
    # add effects


func _pickup_powerUp(body: Node) -> void:
    body.pickUp(self)


"""
    Power Up (Function)
"""

func apply_repearing(value: float):
    print("applying repearing")


func apply_speed_boost(boost_time: float):
    print("applying speed boost")


func apply_score_boost(increament_in_score: float):
    print("applying score boost")
