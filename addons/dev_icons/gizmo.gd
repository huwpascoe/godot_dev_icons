extends EditorNode3DGizmo

var material: StandardMaterial3D
var color: Color
var size: float

func _redraw() -> void:
	clear()
	add_unscaled_billboard(material, size, color)
