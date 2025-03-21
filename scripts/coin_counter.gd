extends Label

func _process(delta):
	self.text = "Coins : " + str(global.coins)
