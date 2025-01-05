extends TextureRect
@onready var music_slider = get_node("MusicSlider")
@onready var SFX_slider = get_node("SFXSlider")
@onready var master_slider = get_node("MasterSlider")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	master_slider.value = AudioManager.master_value
	SFX_slider.value = AudioManager.sfx_value
	music_slider.value = AudioManager.music_value
func _process(delta: float) -> void:
	AudioManager.master_value = master_slider.value
	AudioManager.sfx_value = SFX_slider.value
	AudioManager.music_value = music_slider.value
