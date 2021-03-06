extends Camera2D
# Camera


onready var parent = Global.ship


func _ready() -> void:
    Global.camera = self


func _process(_delta: float) -> void:
    if parent:
        if is_instance_valid(parent):
            global_position.y = parent.global_position.y - (get_viewport_rect().size.y / 2) / 2
