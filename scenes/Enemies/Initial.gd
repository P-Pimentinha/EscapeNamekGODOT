extends State


func Enter():
	pass
	

func Update(_delta : float):
	pass
		

func Physics_Update(_delta : float):
	state_transition.emit(self, "LevelOne")
	
	
	
func Exit():
	pass
