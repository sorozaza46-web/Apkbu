extends CharacterBody3D

@onready var mesh_instance: MeshInstance3D = $MeshInstance3D
@onready var color_ray: RayCast3D = $RayCast3D
@onready var whistle_audio: AudioStreamPlayer3D = $AudioStreamPlayer3D

var target_color: Color = Color.WHITE
var color_blend_speed: float = 6.0
var active_material: StandardMaterial3D

func _ready() -> void:
	# Diğer bukalemunların renginin bozulmaması için materyali kişiselleştiriyoruz (Unique)
	var original_mat = mesh_instance.get_active_material(0)
	if original_mat is StandardMaterial3D:
		active_material = original_mat.duplicate()
		mesh_instance.set_surface_override_material(0, active_material)
	else:
		active_material = StandardMaterial3D.new()
		mesh_instance.set_surface_override_material(0, active_material)

func _process(delta: float) -> void:
	# Rengi hedef renge doğru pürüzsüzce yaklaştır (Meccha Chameleon efekti)
	if active_material:
		active_material.albedo_color = active_material.albedo_color.lerp(target_color, delta * color_blend_speed)

# UI butonuna basıldığında çağrılacak renk kopyalama fonksiyonu
func scan_surface_and_paint() -> void:
	if color_ray.is_colliding():
		var collider = color_ray.get_collider()
		if collider is MeshInstance3D:
			var surface_mat = collider.get_active_material(0)
			if surface_mat is StandardMaterial3D:
				target_color = surface_mat.albedo_color
				print("[Sistem] Renk Algılandı: ", target_color)

# Slider bar değiştirildiğinde karakterin boyutunu ayarlar
func adjust_chameleon_scale(new_scale: float) -> void:
	var clamped_val = clamp(new_scale, 0.4, 1.6)
	scale = Vector3(clamped_val, clamped_val, clamped_val)

# Islık çalma mekaniği
func trigger_whistle_sound() -> void:
	if whistle_audio and not whistle_audio.playing:
		whistle_audio.play()
		print("[Meccha Chameleon] Islık çalındı! Avcılar tetikte.")

