extends Node2D

@onready var album_list: Node2D = $AlbumList

var cursongs = []

@onready var time: Label = $Time
@onready var song_name: Label = $SongName
@onready var color_rect: ColorRect = $ColorRect
@onready var progress_bar: HSlider = $ProgressBar
@onready var volume: HSlider = $HSlider
@onready var shader_rect: ColorRect = $ShaderRect

var gradient = load("res://Scripts/main.tres")

var accent = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var file_path = "res://config.txt"
	

	var file = FileAccess.open(file_path,FileAccess.READ)

	if FileAccess.file_exists(file_path):

		var i = -1
		var i2 = 0
		var ignore = false

		while not file.eof_reached():
			var line = file.get_line()
				
			if line == "?-?":
				ignore = true
				continue
				
				
			
			if line != "-----" and !ignore:
				if i2 == 0 and i >= 0:
					Global.anames.append(line)
				elif i2 == 1 and i >= 0:
					Global.acolors.append(line)
				elif i2 == 2 and i >= 0:
					Global.acolors2.append(line)
				elif i2 == 3 and i >= 0:
					Global.apics.append(line)
				elif i2 >= 4 and i >= 0:
					cursongs.append(line)
					
			if ignore:
				accent = line
				ignore = false
			
			if i >= 0:
				i2 += 1
			
			if line == "-----":
				i += 1
				i2 = 0
				if len(cursongs) > 0:
					Global.asongs.append(cursongs.duplicate(false))
					cursongs.clear()
			#print(line)
		
		file.close()
	else:
		get_tree().quit()
		
	#print(accent)
	shader_rect.material.set_shader_parameter("new", Color(accent))
	
	loadall()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	Global.seconds = clamp(Global.seconds,-1,Global.slen - 1)
	
	if Global.secondtimeout:
		progress_bar.value = Global.seconds
		Global.secondtimeout = false
	
	progress_bar.max_value = Global.slen
	time.text = Global.elapsed + " / " + Global.songlength
	song_name.text = Global.cursong
	if Global.chosen:
		color_rect.color = Global.acolors[Global.curindex]
		gradient.gradient.colors = [Color(Global.acolors2[Global.curindex]),Global.acolors[Global.curindex]]
	
	
func showimg(img,node):
	var image = Image.new()
	image.load(img)
	var texture = ImageTexture.new()
	texture.set_image(image)
	node.texture = texture
	
func delimg(node):
	node.texture = null


func _on_up_pressed() -> void:
	if Global.chosen:
		if Global.screen > 0:
			Global.screen -= 1
			
		album_list.get_child(Global.curindex).loadalbum()
	
	$Up2.texture = load("res://Buttons/sprite_02.png")
	$ButtonTimer.start()


func _on_down_pressed() -> void:
	if Global.chosen:
		Global.screen += 1
		album_list.get_child(Global.curindex).loadalbum()
	
	$Down2.texture = load("res://Buttons/sprite_04.png")
	$ButtonTimer.start()


func _on_pause_pressed() -> void:
	Global.playpause()
	
	if $Pause2.texture == load("res://Buttons/sprite_19.png"):
		$Pause2.texture = load("res://Buttons/sprite_20.png")
	else:
		$Pause2.texture = load("res://Buttons/sprite_19.png")


func _on_loop_pressed() -> void:
	Global.loop = !Global.loop
	
	if $Loop2.texture == load("res://Buttons/sprite_13.png"):
		$Loop2.texture = load("res://Buttons/sprite_14.png")
	else:
		$Loop2.texture = load("res://Buttons/sprite_13.png")


func _on_play_pressed() -> void:
	if Global.chosen:
		Global.queue.clear()
		if !Global.shuffle:
			Global.queue = Global.asongs[Global.curindex].duplicate()
		else:
			Global.queue = Global.asongs[Global.curindex].duplicate()
			Global.queue.shuffle()
		Global.playsong(Global.queue[0])
	
	$Play2.texture = load("res://Buttons/sprite_18.png")
	$ButtonTimer.start()


func _on_shuffle_pressed() -> void:
	Global.shuffle = !Global.shuffle
	
	if $Shuffle2.texture == load("res://Buttons/sprite_15.png"):
		$Shuffle2.texture = load("res://Buttons/sprite_16.png")
	else:
		$Shuffle2.texture = load("res://Buttons/sprite_15.png")


func _on_h_slider_value_changed(value: float) -> void:
	Global.changevol(log(value) * 20)
	
func loadall():
	var j = 0
	for x in album_list.get_children():
		
		if j + (30 * Global.albumscreen) >= len(Global.apics):
			delimg(x)
		else:
			showimg(Global.apics[j + (30 * Global.albumscreen)].replace('"',""),x)
		
		j += 1
	


func _on_previous_pressed() -> void:
	if Global.albumscreen > 0:
		Global.albumscreen -= 1
	$Prev2.texture = load("res://Buttons/sprite_10.png")
	$ButtonTimer.start()


func _on_next_pressed() -> void:
	Global.albumscreen += 1
	#loadall()
	$Next2.texture = load("res://Buttons/sprite_06.png")
	$ButtonTimer.start()


func _on_button_timer_timeout() -> void:
	$Up2.texture = load("res://Buttons/sprite_01.png")
	$Down2.texture = load("res://Buttons/sprite_03.png")
	$Prev2.texture = load("res://Buttons/sprite_09.png")
	$Next2.texture = load("res://Buttons/sprite_05.png")
	$Play2.texture = load("res://Buttons/sprite_17.png")
	$Skip.texture = load("res://Buttons/sprite_07.png")
	$GoBack.texture = load("res://Buttons/sprite_11.png")
	loadall()


func _on_progress_bar_drag_ended(value_changed: bool) -> void:
	Global.seconds = int(progress_bar.value)
	Global.audio_player.play(Global.seconds)


func _on_next_3_pressed() -> void:
	if len(Global.queue) > 0 and Global.qindex + 1 < len(Global.queue):
		Global._on_audio_player_finished()
		$Skip.texture = load("res://Buttons/sprite_08.png")
		$ButtonTimer.start()


func _on_previous_2_pressed() -> void:
	if len(Global.queue) > 0 and Global.qindex - 2 > -2:
		Global.qindex -= 2
		Global._on_audio_player_finished()
		$GoBack.texture = load("res://Buttons/sprite_12.png")
		$ButtonTimer.start()
