extends RigidBody2D
# Ship

# tweek mass facter for modify ship control

export (Vector2) var MAX_VELOCITY = Vector2(200, 300)

var thrust = Vector2(0, -1000)
var touque = 10000

var prev_global_position: Vector2 = Vector2.ZERO

onready var lt = $leftThuster
onready var rt = $rightThuster

onready var thuster_sfx = $ThursterSFX

func _ready() -> void:
    Global.ship = self


func _process(delta: float) -> void:
    $CanvasLayer/Label2.text = String(linear_velocity)
    $CanvasLayer/Label3.text = String(angular_velocity)
    Global.constrain_in_screen(self, Vector2(16, 16))
    
    # clamping 
    
    angular_velocity = clamp(angular_velocity, -5, 5)
    
    if linear_velocity.x > MAX_VELOCITY.x:
        linear_velocity.x = lerp(linear_velocity.x, MAX_VELOCITY.x, 10 * delta)
    elif linear_velocity.x < -MAX_VELOCITY.x:
        linear_velocity.x = lerp(linear_velocity.x, -MAX_VELOCITY.x, 10 * delta)
    
    if linear_velocity.y < -MAX_VELOCITY.y:
        linear_velocity.y = lerp(linear_velocity.y, -MAX_VELOCITY.y, 10 * delta)
    elif linear_velocity.y > MAX_VELOCITY.y:
        linear_velocity.y = lerp(linear_velocity.y, MAX_VELOCITY.y, 10 * delta)


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


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("space"):
        apply_impulse(Vector2.ZERO, Vector2(0, -900).rotated(rotation))


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
    pass
#    queue_free()
