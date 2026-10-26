class_name IraqBadge
extends Control
## شعار اللعبة: رأس أسد واقعي يدور باستمرار حول محوره الرأسي، وتحته عبارة «صنع في العراق» بالعربية.

const LION_PATH := "res://assets/lion_head.png"

var sz := 120.0
var spin := true
var with_text := true
var t := 0.0
var head: TextureRect
var lbl: Label


func setup(s: float, spinning := true, with_label := true) -> IraqBadge:
	sz = s
	spin = spinning
	with_text = with_label
	var fs: int = clampi(int(s * 0.17), 13, 34)
	var th: float = float(fs) * 1.55 if with_text else 0.0
	var w: float = s * 1.5
	custom_minimum_size = Vector2(w, s + th + 2.0)
	size = custom_minimum_size
	mouse_filter = Control.MOUSE_FILTER_IGNORE

	head = TextureRect.new()
	head.mouse_filter = Control.MOUSE_FILTER_IGNORE
	head.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	head.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	head.texture_filter = CanvasItem.TEXTURE_FILTER_LINEAR
	if ResourceLoader.exists(LION_PATH):
		head.texture = load(LION_PATH)
	head.size = Vector2(s, s)
	head.position = Vector2((w - s) * 0.5, 0.0)
	head.pivot_offset = Vector2(s * 0.5, s * 0.5)
	add_child(head)

	if with_text:
		lbl = Label.new()
		lbl.text = "صنع في العراق"
		lbl.mouse_filter = Control.MOUSE_FILTER_IGNORE
		lbl.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		lbl.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
		lbl.position = Vector2(0.0, s + 2.0)
		lbl.size = Vector2(w, th)
		lbl.add_theme_font_size_override("font_size", fs)
		lbl.add_theme_color_override("font_color", Color(1.0, 0.93, 0.7))
		lbl.add_theme_color_override("font_outline_color", Color(0.1, 0.06, 0.02, 0.95))
		lbl.add_theme_constant_override("outline_size", maxi(3, int(fs * 0.22)))
		add_child(lbl)
	set_process(spin)
	return self


func _notification(what: int) -> void:
	if what == NOTIFICATION_VISIBILITY_CHANGED or what == NOTIFICATION_ENTER_TREE:
		set_process(spin and is_visible_in_tree())


func _process(delta: float) -> void:
	t += delta
	var c: float = cos(t * 1.7)
	var sc: float = c
	if absf(c) < 0.06:
		sc = 0.06 if c >= 0.0 else -0.06
	head.scale = Vector2(sc, 1.0)
	var shade: float = 0.4 * (1.0 - absf(c))
	head.modulate = Color(1.0 - shade, 1.0 - shade, 1.0 - shade, 1.0)
