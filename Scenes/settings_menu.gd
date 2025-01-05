extends TextureRect
@onready var master_slider = get_node("MasterSlider")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_slider.value = AudioManager.master_value
func _process(delta: float) -> void:
	AudioManager.master_value = master_slider.value
