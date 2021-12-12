extends RigidBody2D
# Ship

# tweek mass facter for modify ship control

var thrust = Vector2(0, -450)
var touque = 5000


func _ready() -> void:
    Global.ship = self


func _process(delta: float) -> void:
    Global.constrain_in_screen(self)


func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
    if Input.is_action_pressed("w"):
        applied_force = thrust.rotated(rotation)
    elif Input.is_action_pressed("s"):
        applied_force = -(thrust / 2).rotated(rotation)
    else:
        applied_force = Vector2.ZERO
    
    var rotation_dir = 0
    
    if Input.is_action_pressed("d"):
        rotation_dir += 1
    
    if Input.is_action_pressed("a"):
        rotation_dir -= 1
    
    applied_torque = rotation_dir * touque
