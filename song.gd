extends ColorRect

@export var index = 0
@onready var pause_2: Sprite2D = $"../../Pause2"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Label.text = ""


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func changetext(text):
	$Label.text = text

func getindex():
	return index


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("Click"):
		Global.playsong(Global.asongs[Global.curindex][index + (9 * Global.screen)])
		Global.queue.clear()
		Global.qindex = 0
		pause_2.texture = load("res://Buttons/sprite_19.png")
		Global.paused = false
