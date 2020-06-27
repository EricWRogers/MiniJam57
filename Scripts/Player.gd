extends KinematicBody

var speed = 7
var acceleration = 20
var gravity = 9.8
var jump  = 5

export var mouse_sensitivity : float = 0.05

var dir : Vector3 = Vector3()
var vel : Vector3 = Vector3()
var fall : Vector3 = Vector3()

onready var head = $Head

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		head.rotate_x(deg2rad(-event.relative.y * mouse_sensitivity))
		head.rotation.x = clamp(head.rotation.x, deg2rad(-45), deg2rad(45))

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	dir = Vector3()
	
	if not is_on_floor():
		fall.y -= gravity * delta
	
	if Input.is_action_pressed("jump"):
		fall.y = jump
	
	if Input.is_action_pressed("move_forward"):
		dir -= transform.basis.z
	if Input.is_action_pressed("move_backward"):
		dir += transform.basis.z
	if Input.is_action_pressed("move_left"):
		dir -= transform.basis.x
	if Input.is_action_pressed("move_right"):
		dir += transform.basis.x
	
	dir = dir.normalized()
	vel = vel.linear_interpolate(dir * speed, acceleration * delta)
	vel = move_and_slide(vel, Vector3.UP)
	move_and_slide(fall, Vector3.UP)
