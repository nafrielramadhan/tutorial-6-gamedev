extends Node2D

@onready var coins_label = $CoinsLabel  # Ambil Label bernama CoinsLabel

func _ready():
	coins_label.text = "Coins Collected: " + str(global.coins)  # Tampilkan jumlah koin
