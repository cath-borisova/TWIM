extends RigidBody3D

var camera = null
var right_hand = null
var left_hand = null
var count = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	camera = %XRCamera3D
	right_hand = %RightController
	left_hand =  %LeftController
	print(right_hand)
	self.freeze = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if self == right_hand.grabbed_object or self == left_hand.grabbed_object:
		var new_shape_scene = load("res://scenes/mini_bush.tscn")
		var new_shape = new_shape_scene.instantiate()
		get_node("/root/Main").add_child(new_shape)
		if self == right_hand.grabbed_object:
			right_hand.is_mini = true
			new_shape.global_position = right_hand.global_position
		else:
			left_hand.is_mini = true
			new_shape.global_position = left_hand.global_position
		new_shape.name = "mini_bush " + str(count)
		count += 1
		new_shape.freeze = true
		if self == right_hand.grabbed_object:
			right_hand.grabbed_object = new_shape
		else:
			left_hand.grabbed_object = new_shape
	else:
		var new_position = camera.global_position + -(camera.global_transform).basis.z.normalized() * 0.5 - -(camera.global_transform).basis.x.normalized() * 0.2
		new_position.y = 1
		
		self.global_transform.origin = new_position
		var projected_camera_pos = camera.global_position
		projected_camera_pos.y = 1
		
		self.look_at(projected_camera_pos, Vector3(0, 1, 0))
		
	
