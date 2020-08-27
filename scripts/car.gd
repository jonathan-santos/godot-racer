extends VehicleBody

export (float) var max_engine_force := 200.0
export (float) var max_brake_force := 5.0
export (float) var max_steer_angle := 0.5

export (float) var steer_speed := 5.0
var steer_target := 0.0
var steer_angle := 0.0

#var joy_steering := JOY_ANALOG_LX
#var steering_mult := -1.0
#var joy_throttle := JOY_ANALOG_R2
#var throttle_mult := 1.0
#var joy_brake := JOY_ANALOG_L2
#var brake_mult := 1.0

func _physics_process(delta):
#	var steer_val = steering_mult + Input.get_joy_axis(0, joy_steering)
#	var throttle_val = throttle_mult + Input.get_joy_axis(0, joy_throttle)
#	var brake_val = brake_mult + Input.get_joy_axis(0, joy_brake)
	var steer_val = 0
	var throttle_val = 0
	var brake_val = 0
	
	if Input.is_action_pressed("ui_up"):
		throttle_val = 1.0
	if Input.is_action_pressed("ui_down"):
		brake_val = 1.0
	if Input.is_action_pressed("ui_left"):
		steer_val = 1.0
	if Input.is_action_pressed("ui_right"):
		steer_val = -1.0
		
	engine_force = throttle_val * max_engine_force
	brake = brake_val * max_brake_force
	
	steer_target = steer_val * max_steer_angle
	if steer_target < steer_angle:
		steer_angle -= steer_speed * delta
		if steer_target > steer_angle:
			steer_angle = steer_target
	elif steer_target > steer_angle:
		steer_angle += steer_speed * delta
		if steer_target < steer_angle:
			steer_angle = steer_target
	
	print(linear_velocity)
	steering = steer_angle
