extends Node

enum TypeOfPlay {SINGLE_PLAYER, MULTI_PLAYER}
enum Goal {TIME, SCORE, NEVER}


var ai = load("res://actors/AiController.tscn")

var starting_point_left = Vector2(120, 512)
var starting_point_right = Vector2(888, 512)

var game_over_time = 99
var game_over_score = 1500

var victory_condition = Goal.TIME

var play_type = TypeOfPlay.SINGLE_PLAYER
