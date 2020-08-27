extends Camera

export (NodePath) var follow_this_path = null
export (float) var target_distance := 3.0
export (float) var target_height := 2.0

var follow_this: Spatial = null
var last_lookat: Vector3

func _ready():
	follow_this = get_node(follow_this_path)
	last_lookat = follow_this.global_transform.origin
	
func _physics_process(delta):
	var delta_v = global_transform.origin - follow_this.global_transform.origin
	var target_pos = global_transform.origin
	
	delta_v.y = 0
	
	if delta_v.length() > target_distance:
		delta_v = delta_v.normalized() * target_distance
		delta_v.y = target_height
		target_pos = follow_this.global_transform.origin + delta_v
	else:
		target_pos.y = follow_this.global_transform.origin.y + target_height
		
	global_transform.origin = global_transform.origin.linear_interpolate(target_pos, delta * 20)
	last_lookat = last_lookat.linear_interpolate(follow_this.global_transform.origin, delta * 20)
	look_at(last_lookat, Vector3.UP)
