extends Node                                                     
 
export(float) var scroll_speed = 0.2     
						   
func _ready():                                                          
	self.material.set_shader_param("scroll_speed", scroll_speed)          

func set_scroll_speed(_speed):
	scroll_speed = _speed         
	self.material.set_shader_param("scroll_speed", scroll_speed) 
	#Emit signal
