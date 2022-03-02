tool
extends Node2D
class_name Interactable

onready var animations = $AnimationPlayer
onready var InteractSprite = $Sprite


"""
----------------------------------
DE GOUDEN GIDS VOOR INTERACTABLES
----------------------------------

HOOFDSTUK 1: TOEVOEGEN NIEUWE INTERACTABLE

Volgende stappen moeten altijd gevolgd worden:
	1. Kies Scene -> New Inherited Scene
	2. Navigeer naar res://Entities/Interactable
	3. Selecteer Interactable.tscn
	4. Bewerk de Sprite child van de inherited scene
	5. Verander Root naam naar de gewenste naam
	6. Ga naar Area2D/CollisionPolygon2D en selecteer deze
	7. Maak de shape property hiervan uniek
		- Right click op shape -> make unique
		- OF klik op de wrench/schroevendraaier naast filter properties
			en selecteer make sub-resources unique
	8. Verander de CollisionPolygon2D shape zoals gewenst
	9. Save

Proficiat, u heeft net u eigen interactable gemaakt


HOOFDSTUK 2: BEWERKEN VAN UW FAVORIETE INTERACTABLES

We kennen het allemaal: u maakte net uw nieuwe favoriete interactable, MAAR
het is niet interactable en doet niets. Niet getreurd, dit hoofdstuk biedt raad!

Voor uw interactable functionaliteit te geven is het noodzakelijk dit script te extenden
Dit kan verwezelijkt worden door hetvolgende:
	1. Right click op Root node
	2. Selecteer Extend Script

Wat kan u van dit script verwachten?
Alles wat u maar wilt in feite. Er zijn een aantal zaken die het gemakkelijker
maken voor u.

SECTIE 1: enable/disable

Voor het (de)activeren van u interactable is het voldoende om de disable_on of enable_on
property te vullen in de _ready functie

eg. 	func _ready():
			enable_on = [StateManager.GARAGE.INIT]
			disable_on = [StateManager.GARAGE.PHONE_PICKED_UP]
			
Soms is het gewenst extra dingen te doen bij het veranderen van state
Dan kan de functie _on_gameState_change overschreven worden.
Belangrijk hier is dat de functie uit het parent script ook uitgevoerd moet worden

eg. 	func _on_gameState_change(_level, state):
			._on_gameState_change(_level, state)
			# Uw fantastische code die uitgevoerd wordt op state change

SECTIE 2: Interacties

Interactie implementeren kan gedaan worden in de interact() functie.
De enige regel hier is dat deze functie volgende structuur volgt

func interact():
	if not enabled or not can_be_clicked:
		return
	
	# Uw magische interactie code
	# Waarbij u de state kan gebruiken of whatever
	
	complete()
	
BELANGRIJK: complete() moet ALTIJD gecalled worden op het einde van executie
Indien u een eerder return wenst te doen uit de interact functie, moet deze
voorafgegaan zijn door een complete() call. 
(de enige uitzondering geldt bij de eerste check if statement)


HOOFDSTUK 3: ENKELE NUTTIGE FUNCTIES

SECTIE 1: messaging

Gemakkelijk berichten sturen in een round robin fashion kan gedaan worden als volgt:
	1. Maak een dictionary aan genaamd messages
	2. De key van deze dict is het INSANITY level
	3. De value van deze dict is een lijst van mogelijke tekstjes
	4. gebruik de functie send_round_robin(messages, [offset])
		(offset is optioneel)
	5. Proficiat u stuurt nu leuke berichtjes, mogelijks wilt u wachten tussen
		berichten doe dit dan adhv yield(get_tree().create_timer(time), "timeout")

SECTIE 2: overige acties

Print insanity overlay
	emit_signal("action_insanity", "insane tekst enzo")
Het level van insane-heid wordt bepaald adhv StateManager.insanity_level


HOOFDSTUK 3: TERMS OF SERVICE

We zijn niet verantwoordelijk voor eventuele ongevallen, dit omvat:
	- u eigen haar uittrekken omdat het ni werkt
	- u voor de kop slaan omdat het nog steeds ni werkt
	- van den trap sjarelen

Bij enige problemen kan u terecht bij onze ombudsdienst
Enkel binnen de kantoor uren (tussen 16u en 16u30 op maandag)

"""



# warning-ignore:unused_signal
signal action_message(string, offset)
# warning-ignore:unused_signal
signal action_telephone(state)
# warning-ignore:unused_signal
signal on_interact(with)
# warning-ignore:unused_signal
signal action_end_level()
# warning-ignore:unused_signal
signal action_insanity(text)
signal resume

# Pausing/enabling/disabling variables
var enabled = false
var prev_enabled = false
var is_paused = false

# Outline specific variables
var can_be_clicked = false
var mouse_in = false
var mouse_was_in = false
var detected = false

# Enabling and disabling variables
# Add the game states in the derived scene scripts
var enable_on = []
var disable_on = []

# Debug variables
export var debug_draw = true setget set_debug
export var detection_radius = 200 setget set_radius


# Round robin functionality
var current_message = 0
func round_robin_message(messages):
	if len(messages) == 0:
		return ""
	current_message = current_message % len(messages)
	var msg = messages[current_message]
	current_message += 1
	return msg
	

func send_round_robin(messages, offset=0):
	if StateManager.insanity_level > 2:
		return
	if not messages.has(StateManager.insanity_level):
		return
	var msg = round_robin_message(messages[StateManager.insanity_level])
	if msg and msg != "":
		specific_message(msg, offset)

# Wrapper around emit signal
func specific_message(msg, offset=0):
	emit_signal("action_message", msg, offset)

# Sets the debug circle radius
func set_radius(value):
	detection_radius = value
	update()
	
# Enable/disable debug
func set_debug(value):
	debug_draw = value
	update()

# Makes sure the Area2D is enabled
func _ready():
	if not Engine.editor_hint:
		$Area2D.visible = true
	else:
		$Area2D.visible = false


# Show outline if allowed
func _on_mouse_over():
	if detected and enabled and not mouse_in:
		play_anim()
	mouse_in = true

# Remove outline if required
func _on_mouse_exit(update=true):
	if mouse_in and enabled and detected:
		play_anim(true)
	mouse_in = false

# Plays the outline animation
func play_anim(back = false):
	if back:
		animations.play_backwards("mouse enter")
	else:
		animations.play("mouse enter")
	can_be_clicked = not back


# Check whether the source pos is in the range of the interactable
func check_in_range(source_pos: Vector2):
	
	if not enabled:
		return
	
	var dist = source_pos.distance_to(self.global_position)
	detected = dist <= detection_radius
	
	
	if not detected and can_be_clicked:
		InteractSprite.material.set_shader_param("thickness", 0)
		can_be_clicked = false
	if detected and mouse_in and not can_be_clicked:
		play_anim()
		
# Draw the debug circle	
func _draw():
	if Engine.editor_hint and debug_draw:
		var radius = detection_radius / self.scale.x
		draw_circle(Vector2.ZERO, radius, Color(1,1,1,0.5))

# Interact with the object
# Override this method
func interact():	
	if not enabled or not mouse_in:
		return

# Function to indicate that the interactable action is finished
func complete():
	emit_signal("resume")


# Handle game state changes
# Make sure each required interactable performs this
func _on_gameState_change(_level, state):

	current_message = 0		# Important, reset pointer to messages

	# Not that when enabled, it stays enabled
	# EXCEPT when the state is in disabled!
	
	if state in enable_on:
		enable()
	if state in disable_on:
		disable()

# Enable the interactable
func enable():
	enabled = true
	prev_enabled = true
	
# Disable the interactable
func disable():
	enabled = false
	prev_enabled = false
	
	if mouse_in or can_be_clicked:
		_on_mouse_exit()

# Pause the interactable
func pause():
	if not is_paused:
		if enabled and can_be_clicked:
			play_anim(true)
		prev_enabled = enabled
		enabled = false
		is_paused = true
		mouse_was_in = mouse_in

# Resume the interactable
func unpause():
	if is_paused:
		enabled = prev_enabled
		is_paused = false
		if enabled and mouse_was_in and mouse_in:
			mouse_was_in = false
			play_anim()
		
			
