//WRYN ORGAN
/obj/item/organ/internal/wryn/hivenode
	species_type = /datum/species/wryn
	name = "antennae"
	organ_tag = "antennae"
	icon = 'icons/mob/human_races/r_wryn.dmi'
	icon_state = "antennae"
	parent_organ = "head"
	slot = "hivenode"

/obj/item/organ/internal/wryn/glands
	name = "wryn wax glands"
	parent_organ = "mouth"
	icon_state = "liver-x"
	slot = "wax glands"
	var/datum/action/innate/honeycomb/honeycomb = new
	var/datum/action/innate/honeyfloor/honeyfloor = new
	var/datum/action/innate/toggle_producing/toggle_producing = new
	var/wax = 25
	var/producing = FALSE

/obj/item/organ/internal/wryn/glands/insert(mob/living/carbon/M, special = 0)
	..()
	honeycomb.Grant(M)
	honeyfloor.Grant(M)
	toggle_producing.Grant(M)

/obj/item/organ/internal/wryn/glands/remove(mob/living/carbon/M, special = 0)
	honeycomb.Remove(M)
	honeyfloor.Remove(M)
	toggle_producing.Remove(M)
	. = ..()

/datum/action/innate/honeycomb
	name = "Secrete Wax"
	desc = "Secrete Wax"
	button_icon_state = "alien_resin"

/datum/action/innate/honeycomb/Activate()
	var/mob/living/carbon/human/wryn/host = owner

	if(host.getWax() >= 50)
		var/choice = input("Что бы построить...","Строительство") as null|anything in list("соты","прозрачные соты") //would do it through typesof but then the player choice would have the type path and we don't want the internal workings to be exposed ICly - Urist

		if(!choice || host.getWax() < 50)	return

		if(do_after(usr, 50, target = usr))
			host.adjustWax(-50)
			for(var/mob/O in viewers(host, null))
				O.show_message(text("<span class='alert'>[host] выделяет кучу воска и формирует из неё [choice]!</span>"), 1)
			switch(choice)
				if("соты")
					new /obj/structure/alien/resin/wall(host.loc)
				if("прозрачные соты")
					new /obj/structure/alien/resin/membrane(host.loc)

	else
		to_chat(owner, "<span class='notice'>Не хватает воска!</span>")

	return

/datum/action/innate/honeyfloor
	name = "Honey Floor"
	desc = "Honey Floor"
	button_icon_state = "alien_plant"

/datum/action/innate/honeyfloor/Activate()
	var/mob/living/carbon/human/wryn/host = owner

	if(locate(/obj/structure/alien/weeds) in get_turf(owner))
		to_chat(owner, "<span class='notice'>Пол здесь уже готов.</span>")
		return
	if(host.getWax() >= 25)
		if(do_after(usr, 10, target = usr))
			host.adjustWax(-25)
			for(var/mob/O in viewers(owner, null))
				O.show_message(text("<span class='alertalien'>[owner] высрал что-то на пол и, кажется, очень доволен этим!</span>"), 1)
			new /obj/structure/alien/weeds(owner.loc)
	else
		to_chat(owner, "<span class='notice'>Не хватает воска!</span>")
	return

/datum/action/innate/toggle_producing
	name = "Toggle Wax Producing"
	button_icon_state = "alien_plant"

/datum/action/innate/toggle_producing/Activate()
	var/mob/living/carbon/human/host = owner
	host.toggle_producing()

/obj/item/organ/internal/eyes/wryn
	species_type = /datum/species/wryn
	see_in_dark = 3

/obj/item/organ/external/tail/wryn
	species_type = /datum/species/wryn
	name = "wryn tail"
	icon_name = "wryntail_s"
	max_damage = 35
	min_broken_damage = 25
