extends Node

signal combo_updated(combo)
signal score_updated(score)
signal geometry_missed()

enum ScoreType {
	PERFECT,
	GOOD,
	OK,
}

const SCORE_DATA = {
	ScoreType.PERFECT: {"text": "Perfect", "color": Color.purple},
	ScoreType.GOOD: {"text": "Good", "color": Color.green},
	ScoreType.OK: {"text": "OK", "color": Color.yellow},
}
const USER_FILE = "user://data.save"

var score = 0
var combo = 0

var scores_count = {}
var max_combo = 0

func save_highscore():
	var high_score = get_highscore()
	
	if high_score and score < high_score:
		return
	
	var file = File.new()
	file.open(USER_FILE, File.WRITE)
	file.store_line(str(score))
	file.close()

func get_highscore():
	var file = File.new()
	if file.file_exists(USER_FILE):
		file.open(USER_FILE, File.READ)
		return int(file.get_line())


func get_color(score: int) -> Color:
	return SCORE_DATA[score]["color"]
	
	
func get_text(score: int) -> String:
	return SCORE_DATA[score]["text"]


func reset_score() -> void:
	score = 0
	combo = 0
	scores_count = {
		null: 0,
		ScoreType.PERFECT: 0,
		ScoreType.GOOD: 0,
		ScoreType.OK: 0
	}
	
	emit_signal("score_updated", score)
	emit_signal("combo_updated", combo)

func increase_score(type: int = ScoreType.OK) -> void:
	var score_amount = 1
	if type == ScoreType.GOOD:
		score_amount *= 3
	if type == ScoreType.PERFECT:
		score_amount *= 5
		
	scores_count[type] += 1
	
	combo += 1
	max_combo = max(combo, max_combo)
	score += score_amount * combo

	emit_signal("score_updated", score)
	emit_signal("combo_updated", combo)


func missed() -> void:
	combo = 0
	scores_count[null] += 1
	emit_signal("geometry_missed")
	emit_signal("combo_updated", combo)
