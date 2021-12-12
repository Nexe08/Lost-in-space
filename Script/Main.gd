extends Node2D
# main

export var astroid_density = 40 # onscreen count of astroid

onready var ww = get_viewport().get_visible_rect().size.x
onready var wh = get_viewport().get_visible_rect().size.y

var a = preload("res://PlaceHolder/astroied.tscn")


func _ready() -> void:
    randomize()
    
# warning-ignore:return_value_discarded
    Global.connect("astroid_destroyed", self, "_on_astroid_destroyed")
    
    for _i in range(astroid_density):
        _spawn_astroid()

# for testing we gonna spawn astroied in side screen
func _spawn_astroid():
    var instance = a.instance()
    add_child(instance)


# signal connection
func _on_astroid_destroyed():
    # spawn new astriod in reqired place
    _spawn_astroid()
