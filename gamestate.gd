extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var screen_width = 512
var client : NakamaClient
var session : NakamaSession = null

const CONFIG_FILE = "user://settings.cfg"

# Called when the node enters the scene tree for the first time.
func _ready():
	print_debug("in gamestate ready")
	# load INI file
	var config = ConfigFile.new()
	var server : String
	var err = config.load(CONFIG_FILE)
	if err == OK: # If not, something went wrong with the file loading
		# Look for the display/width pair, and default to 1024 if missing
		screen_width = config.get_value("display", "width", 1024)
		server = config.get_value("client", "server", "127.0.0.1")
		# Store a variable if and only if it hasn't been defined yet
		if not config.has_section_key("audio", "mute"):
			config.set_value("audio", "mute", false)
		# Save the changes by overwriting the previous file
		config.save(CONFIG_FILE)
	else:
		print_debug("in gamestate ready: config file error: ", err)
		config.set_value("audio", "mute", false)
		# Attempt to save the config file to create it
		config.save(CONFIG_FILE)
		
	Nakama.logger = NakamaLogger.new("MyLogger", NakamaLogger.LOG_LEVEL.DEBUG)
	client = Nakama.create_client("defaultkey", server, 7350, "http")
	var token = config.get_value("client", "token", "")
	if token:
		var restored_session = client.restore_session(token)
		if restored_session.valid and not restored_session.expired:
			session = restored_session
	else:
		var deviceid = OS.get_unique_id()
		session = yield(client.authenticate_device_async(deviceid), "completed")
		if not session.is_exception():
			config.set_value("client", "token", session.token)
			config.save(CONFIG_FILE)
	print(session._to_string())

	
	# parse command line args
	print_debug("Command line: ", OS.get_cmdline_args())
	var arguments = {}
	for argument in OS.get_cmdline_args():
		if argument.find("=") > -1:
			var key_value = argument.split("=")
			arguments[key_value[0].lstrip("--")] = key_value[1]
	print_debug("Parsed command line arguments: ", arguments)
	
	print_debug("Screen width: ", screen_width)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
