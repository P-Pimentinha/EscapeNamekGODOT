extends VBoxContainer




func _on_volume_slider_value_changed(value):
	set_volume(0, value)

func set_volume(idx,value):
	AudioServer.set_bus_volume_db(idx, linear_to_db(value))
