extends RigidBody2D
# Ship

# tweek mass facter for modify ship control

export (float) var MAX_VELOCITY = 300

var thrust = Vector2(0, -450)
var touque = 5000

onready var lt = $leftThuster
onready var rt = $rightThuster


func _ready() -> void:
    Global.ship = self


func _process(delta: float) -> void:
    print(linear_velocity)
    Global.constrain_in_screen(self, $Sprite.texture.get_size())


func _integrate_forces(_state: Physics2DDirectBodyState) -> void:
    if Input.is_action_pressed("w"):
        lt.emitting = true
        rt.emitting = true
        applied_force = thrust.rotated(rotation)
    elif Input.is_action_pressed("s"):
        applied_force = -(thrust / 2).rotated(rotation)
    else:
        lt.emitting = false
        rt.emitting = false
        applied_force = Vector2.ZERO
    
    var rotation_dir = 0
    
    if Input.is_action_pressed("d"):
        rotation_dir += 1
    
    if Input.is_action_pressed("a"):
        rotation_dir -= 1
    
    applied_torque = rotation_dir * touque
    
    linear_velocity.x = clamp(linear_velocity.x, -MAX_VELOCITY / 2, MAX_VELOCITY / 2)
    linear_velocity.y = clamp(linear_velocity.y, -MAX_VELOCITY, MAX_VELOCITY)
