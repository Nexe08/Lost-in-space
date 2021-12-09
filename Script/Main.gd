extends Node2D
# main

onready var ww = get_viewport().get_visible_rect().size.x
onready var wh = get_viewport().get_visible_rect().size.y

var a = preload("res://PlaceHolder/astroied.tscn")


func _ready() -> void:
    randomize()
    _spawn_astroid()

# for testing we gonna spawn astroied in side screen
func _spawn_astroid():
    for i in range(20):
#        var spawn_point = Vector2(rand_range(0, ww), rand_range(0, wh))
        var instance = a.instance()
#        instance.global_position = spawn_point
        add_child(instance)
