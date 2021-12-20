extends Node
# Global

# warning-ignore:unused_signal
signal astroid_destroyed

onready var screen_size = get_viewport().get_visible_rect().size

var camera
var ship


var power_up_path: PackedScene = preload("res://Scene/PowerUp/PowerUp.tscn")

func _ready() -> void:
    randomize()


func constrain_in_screen(node, node_scale: Vector2 = Vector2(32, 32)):
    if node.global_position.x < -node_scale.x:
        node.global_position.x = screen_size.x + node_scale.x
    elif node.global_position.x > screen_size.x + node_scale.x:
        node.global_position.x = -node_scale.x
