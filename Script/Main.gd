extends Node2D
# main

export var astroid_density = 120 # onscreen count of astroid

onready var ww = get_viewport().get_visible_rect().size.x
onready var wh = get_viewport().get_visible_rect().size.y

var a = preload("res://PlaceHolder/astroied.tscn")


func _ready() -> void:
    randomize()
    _spawn_astroid()

# for testing we gonna spawn astroied in side screen
func _spawn_astroid():
    for i in range(astroid_density):
        var instance = a.instance()
        add_child(instance)
