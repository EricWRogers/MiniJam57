extends Area

var bullet_speed : int = 5

func _process(delta):
	#translate(transform.basis.z * bullet_speed * delta)
	translate(Vector3(0,0,-1) * bullet_speed * delta)

func _on_Timer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	queue_free()
