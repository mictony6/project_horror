class_name PlayerState
extends State

const IDLE = "Idle";
const WALKING = "Walking";
const SPRINTING = "Sprinting";
const JUMPING = "Jumping";
const CROUCHING = "Crouching";
const FALLING = "Falling";
const MENU = "Menu";
var player: Player;

func _ready() -> void:
	await owner.ready;
	player = owner as Player;
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.");
