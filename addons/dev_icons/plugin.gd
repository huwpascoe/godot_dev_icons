@tool
extends EditorPlugin

const DevIcons = preload("res://addons/dev_icons/dev_icons.gd")

var _dev_icons := DevIcons.new()


func _enter_tree() -> void:
	add_node_3d_gizmo_plugin(_dev_icons)


func _exit_tree() -> void:
	remove_node_3d_gizmo_plugin(_dev_icons)
