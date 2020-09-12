extends Node

var listeners = {}


func _ready():
	pass # Replace with function body.


# adds a function reference to the list of listeners for the given named event
func listen(event, callback):
	if not listeners.has(event):
		listeners[event] = []
	listeners[event].append(callback)
	
	

# removes a function from listening for an event
func ignore(event, callback):
	if not listeners.has(event):
		if listeners[event].find(callback):
			listeners[event].remove(callback)
	

# calls each callback in the list of callbacks in listeners for the given named event, passing args to each
func shout(event, args):
	if listeners.has(event):
		for callback in listeners[event]:
			callback.call_funcv(args)
