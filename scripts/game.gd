extends Node2D

@onready var countdown_timer = $Timer
@onready var timer_label: Label = $Player/TimerLabel

var total_time = 5 * 60  # 5 minutes in seconds

func _ready():
	update_timer_label()
	countdown_timer.start()
	countdown_timer.timeout.connect(_on_countdown_timer_timeout)

func _on_countdown_timer_timeout():
	total_time -= 1
	if total_time <= 0:
		countdown_timer.stop()
		total_time = 0
		game_over()
	update_timer_label()

func update_timer_label():
	var minutes = int(total_time / 60)
	var seconds = int(total_time % 60)
	timer_label.text = str(minutes).pad_zeros(2) + ":" + str(seconds).pad_zeros(2)

func game_over():
	print("Time’s up!")
	# later we can add restart or death here

# ⭐ THIS IS THE FUNCTION THE TELEPORT SCRIPT CALLS ⭐
func reduce_time(seconds: int) -> void:
	total_time -= seconds # Deduct the time penalty
	if total_time < 0:
		total_time = 0
	update_timer_label() # Immediately update the display
