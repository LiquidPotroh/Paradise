//Spread Flags
#define NON_CONTAGIOUS 0	//virus can't spread
#define SPECIAL 1	 		//virus can spread in specially created procs
#define BLOOD 2		 		//virus can spread with infected blood
#define CONTACT 4	 		//virus can spread with any touch
#define AIRBORNE 8	 		//virus spreads through the air

/datum/disease/virus
	form = "Вирус"

	var/spread_flags = NON_CONTAGIOUS

	///affects how often the virus will try to spread. The more the better. In range [0-100]
	var/infectivity = 65
	///affects how well the virus will pass through the protection. The more the better. In range (0-2]
	var/permeability_mod = 1

/datum/disease/virus/New()
	..()
	additional_info = spread_text()

/**
 * Main virus process, that executed every tick
 *
 * Returns:
 * * TRUE - if process finished the work properlly
 * * FALSE - if don't need to call a child proc
 */
/datum/disease/virus/stage_act()
	if(prob(infectivity))
		spread()

	. = ..()

	if(!. || carrier)
		return FALSE

	return TRUE

/datum/disease/virus/try_increase_stage()
	if(prob(affected_mob.reagents.has_reagent("spaceacillin") ? stage_prob/2 : stage_prob))
		stage = min(stage + 1,max_stages)
		if(!discovered && stage >= CEILING(max_stages * discovery_threshold, 1)) // Once we reach a late enough stage, medical HUDs can pick us up even if we regress
			discovered = TRUE
			affected_mob.med_hud_set_status()

/datum/disease/virus/spread(force_spread = 0)
	if(!affected_mob)
		return

	if((spread_flags <= BLOOD) && !force_spread)
		return

	if(affected_mob.reagents.has_reagent("spaceacillin") || (affected_mob.satiety > 0 && prob(affected_mob.satiety/10)))
		return

	var/spread_range = 1

	if(force_spread)
		spread_range = force_spread

	if(spread_flags & AIRBORNE)
		spread_range++

	var/turf/T = affected_mob.loc
	if(istype(T))
		for(var/mob/living/carbon/C in oview(spread_range, affected_mob))
			var/turf/V = get_turf(C)
			if(V)
				while(TRUE)
					if(V == T)
						Contract(C)
						break
					var/turf/Temp = get_step_towards(V, T)
					if(!V.CanAtmosPass(Temp))
						break
					V = Temp

/datum/disease/virus/proc/spread_text()
	var/list/spread = list()
	if(!spread_flags)
		spread += "Не заразный"
	if(spread_flags & SPECIAL)
		spread += "Специальный"
	if(spread_flags & BLOOD)
		spread += "Распространяемый через кровь"
	if(spread_flags & CONTACT)
		spread += "Контактный"
	if(spread_flags & AIRBORNE)
		spread += "Воздушно-капельный"
	return english_list(spread, "Неизвестен", " и ")

/datum/disease/virus/TryContract(mob/M)
	if(!..())
		return FALSE

	var/obj/item/clothing/Cl = null
	var/passed = TRUE

	if(prob(15/permeability_mod))
		return

	if(M.satiety > 0 && prob(M.satiety/10)) // positive satiety makes it harder to contract the disease.
		return

	if(istype(M, /mob/living/carbon/human))
		var/mob/living/carbon/human/H = M

		switch(pick(40;"head", 40;"body", 10;"hands",  10;"feet"))
			if("head")
				if(isobj(H.head) && !istype(H.head, /obj/item/paper))
					Cl = H.head
					passed = prob((Cl.permeability_coefficient*100) - 1)
				if(passed && isobj(H.wear_mask))
					Cl = H.wear_mask
					passed = prob((Cl.permeability_coefficient*100) - 1)
			if("body")
				if(isobj(H.wear_suit))
					Cl = H.wear_suit
					passed = prob((Cl.permeability_coefficient*100) - 1)
				if(passed && isobj(slot_w_uniform))
					Cl = slot_w_uniform
					passed = prob((Cl.permeability_coefficient*100) - 1)
			if("hands")
				if(isobj(H.wear_suit) && H.wear_suit.body_parts_covered&HANDS)
					Cl = H.wear_suit
					passed = prob((Cl.permeability_coefficient*100) - 1)

				if(passed && isobj(H.gloves))
					Cl = H.gloves
					passed = prob((Cl.permeability_coefficient*100) - 1)
			if("feet")
				if(isobj(H.wear_suit) && H.wear_suit.body_parts_covered&FEET)
					Cl = H.wear_suit
					passed = prob((Cl.permeability_coefficient*100) - 1)

				if(passed && isobj(H.shoes))
					Cl = H.shoes
					passed = prob((Cl.permeability_coefficient*100) - 1)


	if(!passed && (spread_flags & AIRBORNE) && !M.internal)
		passed = (prob((50*permeability_mod) - 1))

	return passed
