/datum/keybinding/alien
	category = KB_CATEGORY_ALIEN

/datum/keybinding/alien/can_use(client/C, mob/M)
	return isalien(M) && ..()

/datum/keybinding/alien/toggle_spit
	name = "Переключить плевок"
	keys = list("H")

/datum/keybinding/alien/toggle_spit/down(client/C)
	. = ..()
	var/mob/living/carbon/alien/A = C.mob
	if(istype(A) && A.get_int_organ(/obj/item/organ/internal/xenos/neurotoxin))
		var/obj/effect/proc_holder/spell/spell = locate(/obj/effect/proc_holder/spell/alien_spell/neurotoxin) in A.mob_spell_list
		spell?.Click()
