extends Node

var anames = []
var acolors = []
var acolors2 = []
var apics = []
var asongs = []

var screen = 0

var albumscreen = 0

var curindex = 0

var paused = false

var songlength = "00:00"
var seconds = 0
var elapsed = "00:00"

var loop = false

var queue = []
var qindex = 0

var shuffle = false

var cursong = ""

var chosen = false

var slen = 1

var secondtimeout = false

@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer
@onready var second: Timer = $AudioPlayer/Second



func playsong(song):
	seconds = 0
	elapsed = stotime(seconds)
	song = song.replace('"',"")
	var import = FileAccess.open(song, FileAccess.READ)
	var sound = AudioStreamMP3.new()
	sound.data = import.get_buffer(import.get_length())
	audio_player.stream = sound
	songlength = stotime(int(audio_player.stream.get_length()))
	audio_player.play()
	second.start()
	cursong = song.get_file().replace(".mp3","").replace(".MP3","").replace('"',"")
	slen = int(audio_player.stream.get_length())

func playpause():
	if paused:
		audio_player.stream_paused = false
		paused = false
	else:
		audio_player.stream_paused = true
		paused = true


func _on_second_timeout() -> void:
	if audio_player.stream_paused == false:
		second.start()
		seconds += 1
		elapsed = stotime(seconds)
		secondtimeout = true
	else:
		second.start()
	
func stotime(total_seconds):
	var minutes = (total_seconds % 3600) / 60
	var seconds = total_seconds % 60
	
	return "%02d:%02d" % [minutes, seconds]


func _on_audio_player_finished() -> void:
	if loop and len(queue) <= 0:
		audio_player.play()
		seconds = 0
		elapsed = stotime(seconds)
		
	if len(queue) > 0:
		qindex += 1
		
		if qindex == len(queue):
			
			if loop:
				qindex = 0
				playsong(queue[qindex])
				seconds = 0
				elapsed = stotime(seconds)
			else:
				queue.clear()
				qindex = 0
				second.stop()
		else:
			playsong(queue[qindex])
			seconds = 0
			elapsed = stotime(seconds)
			

func changevol(vol):
	audio_player.volume_db = vol
