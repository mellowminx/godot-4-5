# removes the radio check on popupmenu items of optionbutton
# code copied from https://www.reddit.com/r/godot/comments/oz45zd/anyway_to_remove_that_radio_button_check_on_the/

func remove_radio_buttons_in_optionbutton_menu(optionbutton : OptionButton) -> void:
	var pm : PopupMenu = optionbutton.get_popup()
	for i in pm.get_item_count():
		if pm.is_item_radio_checkable(i):
			pm.set_item_as_radio_checkable(i, false)
