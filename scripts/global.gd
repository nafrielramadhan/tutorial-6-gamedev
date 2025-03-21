extends Node

var lives= 3

var coins= 0

func add_coin():
	coins += 1  

func decrease_lives():
	if lives > 0:
		lives -= 1
		coins = 0
		
func reset_game():
	lives = 3  
	coins = 0  
