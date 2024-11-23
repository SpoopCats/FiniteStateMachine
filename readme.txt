OVERVIEW OF GAME ARCHITECTURE

Player is governed by a Finite State Machine (FSM). This FSM method was selected
as a coding exercise. It is likely not the best way to program the player. It
has 4 states within the player.tscn scene.

The cat enemies and peanutbutter score bonus spawn just off screen in a series
of lanes. The lanes are calculated as follows to fit on a 640 x 360 window size:
	
	var spawn_points = [
	Vector2(-16, 52),
	Vector2(-16, 84),
	Vector2(-16, 116),
	Vector2(-16, 148),
	Vector2(-16, 180),
	Vector2(-16, 212),
	Vector2(-16, 244),
	Vector2(-16, 276),
	Vector2(-16, 308),
	Vector2(656, 52),
	Vector2(656, 84),
	Vector2(656, 116),
	Vector2(656, 148),
	Vector2(656, 180),
	Vector2(656, 212),
	Vector2(656, 244),
	Vector2(656, 276),
	Vector2(656, 308),
]

X = -16 puts a 32x32 sprite just off screen on the left.
X = 656 puts a 32x32 sprite just off screen on the right.

There are 9 Y values, representing 9 distinct lanes that cats or peanut butter
can spawn in.

There are 3 "manager scenes" to be aware of that can tweak gameplay:
	- enemy_manager = governs enemy spawning in the 9 lanes
	- food_manager = governs the sprites spawning that the player "eats" at the 
		top and bottom of the screen.
	- score_bonus_manager = governs peanut butter score bonus spawning

There are 5 "autoload scenes" to be aware of:
	- GameEvents = a signal bus so signals are available to all scenes/nodes
	- ScoreTracker = makes a score value available to all scenes
	- GameOver = a sound effect that needs to play across the the main.tscn and
		the game_over_menu.tscn
	- GameOverManager = tracks how the game ended with boolean values. Did the
		player hit an enemy or did the game timer expire?
	- BackgroundMusic = globally available so music plays on all scenes

WHATS POTENTIALLY CONFUSING?

The most weakly coded part of the game is the themes for the menus. There is one
main theme: main_theme.tres

button_focus.tres, button_hover.tres, button_pressed.tres are variations of
button_main_style.tres.

If you put main_theme.tres on another menu, it should utilize the 4 button
themes outlined in the last paragraph.

This part could be redone when I have a better understanding of themes. I did it
rather quickly when finishing up the game. However, it works.

Furthermore, there is some vestigial code for "closing" the 9 lanes for spawning
enemies or score bonuses. This was left in to give the option to close off lanes
if and when features are added, when the screen might become too cluttered or
objects that the player wants to hit are blocked by that clutter.

Essentially, the lane closing code will pass a Vector2 between scenes to remove
lanes from an array so nothing can spawn there, or add a lane back into an array
so something can again spawn in that lane.

In it's current state, I haven't had to use lane closing for any reason.

Additionally, the GameOverManager flips some global variable values for how
the game ended:
	var game_over_by_time: bool = false
	var game_over_by_player_hitting_enemy: bool = false
Signals are emitted from game_timer.tscn when the timer runs out that flips
this value to true. If the player hits an enemy it emits a signal that flips the
other value to true. When the replay button is hit in the game_over_menu.tscn
it flips the values back to false.
	The GameOverManager also governs the tutorial which is a bit strange. It
flips a boolean to false on
		var tutorial_needed
	When the replay button is pressed to ensure that the tutorial is only showed
	once.

DIFFICULTY

Difficulty increases at 60 and 30 seconds remaining. The enemy spawns increase,
but the probability of bonuses spawning also increases. These are controlled in
the score_bonus_manager.gd and enemy_manager.gd scripts. Edit these two funcs
to modify the difficulty:
	func _increase_difficulty():
	func _increase_bonus_spawn_rate():

PLAYER_HIT_ENEMY_GAME_OVER SIGNAL
	This signal is emitted from the player FSM from MovingDown and MovingUp
	It is connected to many scripts:
		# player FSM moving_up.gd and moving_down.gd
		# enemy_manager.gd
		# score_bonus_manager.gd
		# enemy.gd = all the enemies on screen
		# score_bonus.gd = all the peanut butter on screen
		# game_timer.gd
		# food.gd

TIME_EXPIRED_GAME_OVER SIGNAL
	Emitted from game_timer.tscn when the timer runs out
	It is connected to many scripts:
		# player FSM all 4x states (wait top, wait btm, moving up, moving down)
		# enemy_manager.gd
		# score_bonus_manager.gd
		# enemy.gd = all the enemies on screen
		# score_bonus.gd = all the peanut butter on screen
		# game_timer.gd
		# food.gd

this signal helps to manage the game over animation that plays when the game
ends by hitting an enemy or by the timer expiring. There are tween functions
that get called in these states.

OTHER WEIRD SHIT
	The player has a scene change timer that changes the scene on game over
	It's odd and really shouldn't be attached to the player but it is.
