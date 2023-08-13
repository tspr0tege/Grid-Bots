extends Camera2D

func _ready():
	zoom = get_viewport_rect().size / Vector2(640, 360)
