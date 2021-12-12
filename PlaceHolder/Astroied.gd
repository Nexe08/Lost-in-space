extends RigidBody2D
# astroid

var destruction_distance = 1024 # double of viewport size


func _ready() -> void:
    global_rotation = rand_range(-1, 1)
    apply_impulse(Vector2.ZERO, Vector2(rand_range(-50, 50), rand_range(-15, 15)))
    add_torque(rand_range(-50, 50))


func _set_position():
    var spawn_point = Vector2(
        rand_range(50, Global.screen_size.x - 50),
        rand_range(Global.ship.global_position.y - 1024,
                    Global.ship.global_position.y - 2048)
    )
    global_position = spawn_point


func _process(_delta: float) -> void:
    Global.constrain_in_screen(self, $Sprite.texture.get_size())
    # calling because it will not run next time
    var distance = global_position.distance_to(Global.ship.global_position)
    
    if distance > destruction_distance:
        _set_position()
#        Global.emit_signal("astroid_destroyed")
#        queue_free()

