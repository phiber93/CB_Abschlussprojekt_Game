class_name SendScores
extends HTTPRequest

const URL = "http://localhost:8080/api/scores/level1/postScore"

var user_id
var score
var time
var level

func _on_request_completed(_result, response_code, _headers, _body):
	if response_code == 200:
		%ScoreSentLabel.visible = true

func send_request(finalScore, finalTimeSurvived, finalUserId, finalLevel):
	%SubmitButton.visible = false
	user_id = finalUserId
	score = finalScore
	time = "00:" + finalTimeSurvived
	level = finalLevel
	
	var headers: PackedStringArray = ["Content-Type: application/json"]
	var data = {
		"user_id" : user_id,
		"score" : str(score),
		"time" : time,
		"level" : str(level)
	}
	var body = JSON.stringify(data)
	
	request(URL, headers, HTTPClient.METHOD_POST, body)
