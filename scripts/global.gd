extends Node


# Quantos inimigos ainda faltam matar
# Quando chegar a 0 = Vitória
var enemies_remaining: int = 0

func reset_enemies():
	enemies_remaining = 0
