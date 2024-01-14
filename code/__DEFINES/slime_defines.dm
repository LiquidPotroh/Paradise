//Slime evolution threshold. Controls how fast slimes can split/grow
#define SLIME_EVOLUTION_THRESHOLD 10
#define SLIME_EVOLUTION_THRESHOLD_OLD 30
#define SLIME_EVOLUTION_THRESHOLD_EVOLVE 50
#define SLIME_EVOLUTION_THRESHOLD_EVOLVE_SLIMEMAN 100

#define SLIME_BABY 		"baby"
#define SLIME_ADULT 	"adult"
#define SLIME_OLD 		"old"
#define SLIME_ELDER 	"elder"
#define SLIME_SLIMEMAN 	"slimeman"

//Slime commands defines
#define SLIME_COMMAND_GREETING 1
#define SLIME_COMMAND_FOLLOW 2
#define SLIME_COMMAND_STAY 3
#define SLIME_COMMAND_STOP 4
#define SLIME_COMMAND_ATTACK 5
#define SLIME_COMMAND_EAT 6
#define SLIME_COMMAND_DEFEND 7

//Minimum levels of friendship to order some commands
#define SLIME_FRIENDSHIP_FOLLOW 			3 //Min friendship to order it to follow
#define SLIME_FRIENDSHIP_STOPEAT 			5 //Min friendship to order it to stop eating someone
#define SLIME_FRIENDSHIP_STOPEAT_NOANGRY	7 //Min friendship to order it to stop eating someone without it losing friendship
#define SLIME_FRIENDSHIP_STOPCHASE			4 //Min friendship to order it to stop chasing someone (their target)
#define SLIME_FRIENDSHIP_STOPCHASE_NOANGRY	6 //Min friendship to order it to stop chasing someone (their target) without it losing friendship
#define SLIME_FRIENDSHIP_STAY				3 //Min friendship to order it to stay
#define SLIME_FRIENDSHIP_ATTACK				8 //Min friendship to order it to attack
#define SLIME_FRIENDSHIP_DEFEND				10 //Min friendship to order it to defend

#define SLIME_HUNGER_NOT_HUNGRY 0
#define SLIME_HUNGER_HUNGRY 1
#define SLIME_HUNGER_STARVING 2

#define SLIME_THAW_TEMPERATURE T0C + 5
#define SLIME_STUN_TEMPERATURE T0C - 40
#define SLIME_HURT_TEMPERATURE T0C - 50

#define SLIME_MAX_TEMPERATURE_DAMAGE 30
#define SLIME_MIN_TEMPERATURE_DAMAGE 5

#define SLIME_BEHAVIOR_ATTACK 1
#define SLIME_BEHAVIOR_EAT 2

#define SLIME_ATTACK_COOLDOWN 4.5 SECONDS

#define SLIME_LOOSE_FRIEND_CHANCE 1
