extends Node
# Global

var ww
var wh

var camera

func _process(delta: float) -> void:
    if camera:
        if is_instance_valid(camera):
            ww = (camera.global_position.x) + (get_viewport().get_visible_rect().size.x)
