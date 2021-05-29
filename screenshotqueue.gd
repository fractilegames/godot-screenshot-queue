extends Node


var thread
var mutex
var queue = []
const MAX_QUEUE_LENGTH = 4


func _ready():
	thread = Thread.new()
	mutex = Mutex.new()


func _exit_tree():
	if thread.is_active():
		thread.wait_to_finish()


func snap(var viewport : Viewport):
	
	var dt = OS.get_datetime()
	var timestamp = "%04d%02d%02d%02d%02d%02d" % [dt["year"], dt["month"], dt["day"], dt["hour"], dt["minute"], dt["second"]]
	
	var image = viewport.get_texture().get_data()
	
	save(image, "user://screenshot-" + timestamp + ".png")


func save(var image : Image, path : String):
	
	mutex.lock()
	
	if queue.size() < MAX_QUEUE_LENGTH:
		queue.push_back({"image" : image, "path" : path})
	else:
		print("Screenshot queue overflow")
	
	if queue.size() == 1:
		if thread.is_active():
			thread.wait_to_finish()
		thread.start(self, "worker_function")
	
	mutex.unlock()


func worker_function(_userdata):
	
	mutex.lock()
	while not queue.empty():
		var item = queue.front()
		mutex.unlock()
		
		print("Saving screenshot to " + item["path"])
		
		item["image"].flip_y()
		item["image"].save_png(item["path"])
		
		mutex.lock()
		queue.pop_front()
	
	mutex.unlock()
