extends StaticBody

signal on_destoryed()

var health = 10
var destoyed = false

export var max_health = 10

func _ready():
	health = max_health

func damage(amount : int):
	health -= amount
	if health <= 0 and not destoyed:
		destoyed = true
		emit_signal("on_destoryed")
		queue_free()
