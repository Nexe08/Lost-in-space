extends RigidBody2D
# PowerUp

enum TYPES{REAPAIRING, SPEED, SCOREBOOST}
export (TYPES) var PowerUpType

onready var sprite = $Sprite


func _ready() -> void:
    var chooice = [TYPES.REAPAIRING, TYPES.SPEED, TYPES.SCOREBOOST]
    chooice.shuffle()
    PowerUpType = chooice[0]
    
    match PowerUpType:
        TYPES.REAPAIRING:
            sprite.frame = 0
        
        TYPES.SPEED:
            sprite.frame = 1
        
        TYPES.SCOREBOOST:
            sprite.frame = 2


func pickUp(node):
    match PowerUpType:
        TYPES.REAPAIRING:
            if node.has_method("apply_repearing"):
                node.apply_repearing(1)
        
        TYPES.SPEED:
            if node.has_method("apply_speed_boost"):
                node.apply_speed_boost(5)
        
        TYPES.SCOREBOOST:
            if node.has_method("apply_score_boost"):
                node.apply_score_boost(10)
