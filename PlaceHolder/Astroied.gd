extends RigidBody2D
# astroid

onready var ww = get_viewport().get_visible_rect().size.x
onready var wh = get_viewport().get_visible_rect().size.y


func _ready() -> void:
    var spawn_point = Vector2(rand_range(0, ww), rand_range(0, wh))
    global_position = spawn_point
    global_rotation = rand_range(-1, 1)
    apply_impulse(Vector2.ZERO, Vector2(rand_range(-50, 50), rand_range(-15, 15)))
    add_torque(rand_range(-50, 50))
