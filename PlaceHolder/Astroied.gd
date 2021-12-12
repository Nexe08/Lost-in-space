extends RigidBody2D
# astroid
onready var sw = get_viewport().get_visible_rect().size.x # screen width
onready var sh = get_viewport().get_visible_rect().size.y # screen height

onready var ww = (Global.camera.global_position.x) + sw / 2 # window width
onready var wh = (Global.camera.global_position.y) + sh / 2 # window heiht

var spawn_distance = 1224 # 200 more then viewport size
var destruction_distance = 2048 # double of viewport size


func _ready() -> void:
    var spawn_point = Vector2(rand_range(-ww, ww * 2), rand_range(-wh, wh))
    global_position = spawn_point
    global_rotation = rand_range(-1, 1)
    apply_impulse(Vector2.ZERO, Vector2(rand_range(-50, 50), rand_range(-15, 15)))
    add_torque(rand_range(-50, 50))


func _process(_delta: float) -> void:
    Global.constrain_in_screen(self, $Sprite.texture.get_size())
    # calling because it will not run next time
    var distance = global_position.distance_to(Global.ship.global_position)
    
    if distance > destruction_distance:
        Global.emit_signal("astroid_destroyed")
        queue_free()
