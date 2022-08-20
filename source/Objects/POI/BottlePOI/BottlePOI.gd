extends POI

func _ready() -> void:
	flavor = '[color=black]Vistas[BOTTLE]'

func activate() -> void:
	get_parent().start_dialog()
