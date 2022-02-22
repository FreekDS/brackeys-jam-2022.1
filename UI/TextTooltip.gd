tool
extends RichTextLabel

onready var tween = $Tween

export(String) var text_content = "" setget set_content
export(int, 1, 100) var font_size = 20 setget set_font_size
export(bool) var play = false setget set_play
export(float) var time_per_letter = 0.1

var can_go = false

func _ready():
	tween.connect("tween_completed", self, "hide_text")

func set_font_size(size):
	font_size = size
	var font = self.get_font("normal_font")
	font.size = font_size
	self.add_font_override("normal_font", font)


func set_play(can_play):
	play = can_play
	if not tween:
		return
	if can_play:
		play_text()
	else:
		self.percent_visible = 0
		if tween.is_active():
			tween.stop_all()
	
func set_content(t):
	text_content = t
	self.bbcode_text = text_content.replace("\\n", "\n")

func play_text():
	visible = true
	can_go = false
	if not tween.is_active():
		tween.interpolate_property(
			self, "percent_visible",
			0, 1,
			time_per_letter * len(self.bbcode_text), 
			Tween.TRANS_LINEAR,
			Tween.EASE_IN_OUT
			)
	tween.start()

func hide_text(_node, _attr):
	can_go = true
	yield(get_tree().create_timer(3), "timeout")
	if can_go:
		visible = false
		can_go = false
	
func set_rect_size(x, y):
	self.set_size(Vector2(x, y))

