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


func _spawn_astroid():
    var instance = a.instance()
    add_child(instance)


func _spawn_power_up(data):
    var power_up_instance = Global.power_up_path.instance()
    power_up_instance.global_position = Vector2(data.position.x, Global.ship.global_position.y - 900)
    add_child(power_up_instance)


# signal connection
func _on_astroid_destroyed():
    # spawn new astriod in reqired place
    _spawn_astroid()


# DEBUG
func _on_PowerUpDestributionTiemerDebug_timeout() -> void:
    _spawn_power_up({"position": Vector2(rand_range(0, 341), 0)})
    _spawn_power_up({"position": Vector2(rand_range(341, 682), 0)})
    _spawn_power_up({"position": Vector2(rand_range(682, 1024), 0)})
