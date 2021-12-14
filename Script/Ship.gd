extends RigidBody2D
# Ship

# tweek mass facter for modify ship control

export var shild: int = 3
export (float) var MAX_VELOCITY = 300

var refill_shild: bool = false

var thrust = Vector2(0, -450)
var touque = 5000

var prev_global_position: Vector2 = Vector2.ZERO

onready var lt = $leftThuster
onready var rt = $rightThuster


func _ready() -> void:
    Global.ship = self


func _process(_delta: float) -> void:
    $CanvasLayer/Label.text = String(shild)
    Global.constrain_in_screen(self, Vector2(16, 16))
    
    if refill_shild:
        shild += 1
        
        if shild == 3: refill_shild = false
    
    # clamping 
    shild = clamp(shild, 0, 3)
    
    linear_velocity.x = clamp(linear_velocity.x, -MAX_VELOCITY / 2, MAX_VELOCITY / 2)
    linear_velocity.y = clamp(linear_velocity.y, -MAX_VELOCITY, MAX_VELOCITY)


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


# Barrier for ship to down side
func _on_PrevPositionAssigner_timeout() -> void:
    if linear_velocity.y < 0: # moving up
        prev_global_position.y = global_position.y + 200
        pass
    elif linear_velocity.y > 0: # moving down
        if global_position.y > prev_global_position.y:
            linear_velocity.y = 0


# collision with astroide
func _on_Ship_body_entered(body: Node) -> void:
    if shild <= 0:
        queue_free()
        return
    
    var collision_speed: Vector2
    var max_collision_speed:= Vector2(200, 200)
    if body is RigidBody2D:
        collision_speed = body.linear_velocity
    
    if abs(linear_velocity.y) > max_collision_speed.y or abs(linear_velocity.x) > max_collision_speed.x or abs(collision_speed.y) > max_collision_speed.y or abs(collision_speed.x) > max_collision_speed.x:
        shild -= 1
        $ShildRefillCooldown.stop()
        $ShildRefillCooldown.start()


func _on_ShildRefillCooldown_timeout() -> void:
    refill_shild = true
