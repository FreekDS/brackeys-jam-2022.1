extends Node2D

signal item_removed(item)
signal item_added(item)

var _items = []

func add_item(item):
	_items.push_back(item)
	emit_signal("item_added", item)

func remove_item(item):
	_items.erase(item)
	emit_signal("item_removed", item)

func has_item(item):
	_items.has(item)


