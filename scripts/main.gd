extends Node3D

func _ready() -> void:
	# 1. Gökyüzü ve Çevre (Environment) Kurulumu
	var env = WorldEnvironment.new()
	env.environment = Environment.new()
	env.environment.background_mode = Environment.BG_CLEAR
	env.environment.clear_color = Color(0.2, 0.2, 0.2)
	add_child(env)

	# 2. Güneş Işığı (DirectionalLight3D)
	var light = DirectionalLight3D.new()
	light.transform.basis = Basis(Vector3.RIGHT, deg_to_rad(-45))
	light.shadow_enabled = true
	add_child(light)

	# 3. Zemin (Floor) Oluşturma
	var floor_body = StaticBody3D.new()
	var floor_collision = CollisionShape3D.new()
	var floor_box_shape = BoxShape3D.new()
	floor_box_shape.size = Vector3(30, 1, 30)
	floor_collision.shape = floor_box_shape
	floor_body.add_child(floor_collision)

	var floor_mesh = MeshInstance3D.new()
	var box_mesh = BoxMesh.new()
	box_mesh.size = Vector3(30, 1, 30)
	floor_mesh.mesh = box_mesh
	
	var floor_mat = StandardMaterial3D.new()
	floor_mat.albedo_color = Color(0.15, 0.6, 0.2) # Yeşil Minecraft çimen rengi
	floor_mesh.set_surface_override_material(0, floor_mat)
	floor_body.add_child(floor_mesh)
	add_child(floor_body)

	# 4. Kamera (Camera3D)
	var camera = Camera3D.new()
	camera.transform = Transform3D(Basis(), Vector3(0, 5, 8))
	camera.transform.basis = Basis(Vector3.RIGHT, deg_to_rad(-30))
	add_child(camera)

	# 5. Bukalemun Oyuncusu (ChameleonPlayer)
	var chameleon_script = load("res://scripts/chameleon.gd")
	var chameleon = CharacterBody3D.new()
	chameleon.name = "ChameleonPlayer"
	chameleon.set_script(chameleon_script)
	chameleon.transform.origin = Vector3(0, 1.1, 0)

	var cham_mesh = MeshInstance3D.new()
	var cap_mesh = CapsuleMesh.new()
	cap_mesh.radius = 0.4
	cap_mesh.height = 1.2
	cham_mesh.mesh = cap_mesh
	cham_mesh.name = "MeshInstance3D"
	chameleon.add_child(cham_mesh)

	var ray = RayCast3D.new()
	ray.target_position = Vector3(0, -2, 0)
	ray.name = "RayCast3D"
	chameleon.add_child(ray)

	var audio = AudioStreamPlayer3D.new()
	audio.name = "AudioStreamPlayer3D"
	chameleon.add_child(audio)
	add_child(chameleon)

	# 6. Mobil Arayüz (UI Control)
	var ui_script = load("res://scripts/ui_controller.gd")
	var ui = Control.new()
	ui.set_script(ui_script)
	ui.set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	ui.chameleon_player = chameleon

	# Boyama Butonu
	var paint_btn = Button.new()
	paint_btn.name = "PaintButton"
	paint_btn.text = "BOYA (PAINT)"
	paint_btn.custom_minimum_size = Vector2(160, 70)
	paint_btn.position = Vector2(300, 550)
	ui.add_child(paint_btn)

	# Islık Butonu
	var whistle_btn = Button.new()
	whistle_btn.name = "WhistleButton"
	whistle_btn.text = "ISLIK ÇAL"
	whistle_btn.custom_minimum_size = Vector2(160, 70)
	whistle_btn.position = Vector2(700, 550)
	ui.add_child(whistle_btn)

	# Boyut Sliderı
	var size_slider = HSlider.new()
	size_slider.name = "SizeSlider"
	size_slider.custom_minimum_size = Vector2(400, 20)
	size_slider.position = Vector2(400, 480)
	ui.add_child(size_slider)

	add_child(ui)
	print("[Sistem] Tüm oyun dünyası ve mobil UI hatasız ayağa kaldırıldı!")

