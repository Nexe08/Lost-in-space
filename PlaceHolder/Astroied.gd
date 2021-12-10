extends RigidBody2D
# astroid
onready var sw = get_viewport().get_visible_rect().size.x # screen width
onready var sh = get_viewport().get_visible_rect().size.y # screen height

onready var ww = (Global.camera.global_position.x) + sw / 2 # window width
onready var wh = (Global.camera.global_position.y) + sh / 2 # window heiht


func _ready() -> void:
    var spawn_point = Vector2(rand_range(-ww, ww * 2), rand_range(-wh, wh))
    global_position = spawn_point
    global_rotation = rand_range(-1, 1)
    apply_impulse(Vector2.ZERO, Vector2(rand_range(-50, 50), rand_range(-15, 15)))
    add_torque(rand_range(-50, 50))


func _process(delta: float) -> void:
    if global_position.y > Global.camera.global_position.y + sh / 2:
        queue_free()
