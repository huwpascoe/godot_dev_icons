extends EditorNode3DGizmoPlugin

const FIXED_SIZE_MULTIPLIER = 0.05
const WORLD_SIZE_MULTIPLIER = 0.5

const DEFAULT_ICON = "res://addons/dev_icons/default.png"
const IconGizmo = preload("res://addons/dev_icons/gizmo.gd")

var _material_cache: Dictionary


func _init() -> void:
	# This is not how gizmos are supposed to be implemented.
	# Don't copy this.
	create_icon_material("fixed", null)
	get_material("fixed").albedo_color = Color.WHITE
	create_icon_material("world", null)
	get_material("world").albedo_color = Color.WHITE
	get_material("world").fixed_size = false


func _get_gizmo_name() -> String:
	return "Dev Icons"


func _has_gizmo(for_node_3d: Node3D) -> bool:
	var s: GDScript = for_node_3d.get_script()
	return s and s.has_method(&"_dev_icon")


func _create_gizmo(for_node_3d: Node3D) -> EditorNode3DGizmo:
	if not _has_gizmo(for_node_3d):
		return null

	var params: Dictionary = for_node_3d.get_script()._dev_icon()

	var gizmo := IconGizmo.new()
	gizmo.set_node_3d(for_node_3d)
	gizmo.size = params.get(&"size", 1.0)
	gizmo.color = params.get(&"color", Color.WHITE)

	var world_scale: bool = params.get(&"world_scale", false)
	gizmo.size *= WORLD_SIZE_MULTIPLIER if world_scale else FIXED_SIZE_MULTIPLIER

	var path: String = params.get(&"path", DEFAULT_ICON)
	var key := "%s_%s" % [path, world_scale]
	if not _material_cache.has(key):
		gizmo.material = get_material("world" if world_scale else "fixed").duplicate()
		gizmo.material.albedo_texture = load(path)
		_material_cache[key] = gizmo.material
	else:
		gizmo.material = _material_cache[key]

	return gizmo
