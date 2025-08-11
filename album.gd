extends TextureRect

@export var index = 0
@export var ogindex = index
@onready var albumname: Label = $"../../Name"
@onready var song_list: Node2D = $"../../SongList"
@onready var flavor_name: Label = $"../../FlavorName"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ogindex = index
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	index = ogindex + (30 * Global.albumscreen)


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("Click"):
		if index < len(Global.anames):
			albumname.text = Global.anames[index]
			loadalbum()
			Global.curindex = index
			Global.chosen = true
	
	if index < len(Global.anames):
		flavor_name.text = Global.anames[index]
	else:
		flavor_name.text = ""
		
	#print(index)
	

func loadalbum():
	for x in song_list.get_children():
		if x.getindex() + (9 * Global.screen) < len(Global.asongs[index]):
			x.changetext(Global.asongs[index][x.getindex() + (9 * Global.screen)].get_file().replace(".mp3","").replace(".MP3","").replace('"',""))
		else:
			x.changetext("")
			
	
