extends Control

# Script global para HUD de barra de vida

@onready var health_bar: TextureProgressBar = $TextureProgressBar

func _ready():
	# Conecta ao sinal de mudança de vida do PlayerStats
	if PlayerStats:
		PlayerStats.health_changed.connect(_on_health_changed)
		# Inicializa a barra com valor 0
		_initialize_health_bar()

func _initialize_health_bar():
	"""Inicializa a barra de vida com valor 0"""
	if health_bar:
		health_bar.max_value = 100
		health_bar.value = 100
		health_bar.fill_mode = TextureProgressBar.FILL_BOTTOM_TO_TOP  # Preenche de baixo para cima

func _on_health_changed(current_health: int, max_health: int):
	"""Atualiza a barra de vida quando a vida mudar"""
	if health_bar:
		health_bar.max_value = max_health
		health_bar.value = current_health

# Função para posicionar o HUD
func set_hud_position(pos: Vector2):
	position = pos

# Função para definir escala do HUD
func set_hud_scale(scale_value: Vector2):
	scale = scale_value
