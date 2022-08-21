extends Bottle

func activate() -> void:
	print("Activating from Expo bottle...")
	.activate()
	if Globals.flags.expo_bottle == false:
		Globals.flags.expo_bottle = true
