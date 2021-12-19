extends RigidBody2D
# PowerUp

enum TYPES{HEALING, SPEED, SCOREBOOST}
export (TYPES) var PowerUpType


func _ready() -> void:
    pass # Replace with function body.


func pickUp(node):
    print(node.name)
