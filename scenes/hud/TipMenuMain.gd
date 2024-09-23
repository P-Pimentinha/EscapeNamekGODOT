extends VBoxContainer


@onready var tips_menu_lv_l_1 = $"../TipsMenuLvL1"
@onready var tips_menu_lv_l_2 = $"../TipsMenuLvL2"
@onready var tips_menu_lv_l_3 = $"../TipsMenuLvL3"


func _on_tips1_button_pressed():
	hide()
	tips_menu_lv_l_1.show()

func _on_tips2_button_pressed():
	hide()
	tips_menu_lv_l_2.show()


func _on_tips3_button_pressed():
	hide()
	tips_menu_lv_l_3.show()
