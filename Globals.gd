extends Node

enum TypeOfPlay {SINGLE_PLAYER, MULTI_PLAYER}
enum Goal {TIME, SCORE, NONE}
enum AiDifficulty {EASY, MODERATE, HARD}


var ai = load("res://actors/AiController.tscn")

var ai_difficulty = AiDifficulty.HARD

var starting_point_left = Vector2(120, 512)
var starting_point_right = Vector2(888, 512)

var game_over_time = 99
var game_over_score = 300

var victory_condition = Goal.TIME

var play_type = TypeOfPlay.SINGLE_PLAYER

var cooldown = 1.0

var bullet_speed = -500

var bullet_life = 3


var main_menu = preload("res://menu/Menu.tscn")
var option_menu = preload("res://menu/Options.tscn")



