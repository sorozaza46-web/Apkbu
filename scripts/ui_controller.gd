extends Control

@export var chameleon_player: CharacterBody3D

@onready var paint_btn: Button = $PaintButton
@onready var whistle_btn: Button = $WhistleButton
@onready var size_slider: Slider = $SizeSlider

func _ready() -> void:
	# Buton ve Slider sinyallerini koda bağlıyoruz
	if paint_btn:
		paint_btn.pressed.connect(_on_paint_pressed)
	if whistle_btn:
		whistle_btn.pressed.connect(_on_whistle_pressed)
	if size_slider:
		size_slider.min_value = 0.5
		size_slider.max_value = 1.5
		size_slider.value = 1.0
		size_slider.value_changed.connect(_on_size_slider_changed)

func _on_paint_pressed() -> void:
	if chameleon_player:
		chameleon_player.scan_surface_and_paint()

func _on_whistle_pressed() -> void:
	if chameleon_player:
		chameleon_player.trigger_whistle_sound()

func _on_size_slider_changed(value: float) -> void:
	if chameleon_player:
		chameleon_player.adjust_chameleon_scale(value)

