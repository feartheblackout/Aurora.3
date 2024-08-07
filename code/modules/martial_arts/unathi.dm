#define TAIL_SWEEP "HHD"
#define SWIFT_DISARM "DDG"
#define HAMMERING_STRIKE "DHD"

/datum/martial_art/kis_khan
	name = "Kis-khan"
	help_verb = /datum/martial_art/kis_khan/proc/kis_khan_help
	no_guns = TRUE
	no_guns_message = "Use of ranged weaponry would be dishonorable."

/datum/martial_art/kis_khan/proc/check_streak(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(findtext(streak,TAIL_SWEEP))
		streak = ""
		tail_sweep(A,D)
		return 1
	if(findtext(streak,SWIFT_DISARM))
		streak = ""
		swift_disarm(A,D)
		return 1
	if(findtext(streak,HAMMERING_STRIKE))
		streak = ""
		hammering_strike(A,D)
		return 1
	return 0

/datum/martial_art/kis_khan/grab_act(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	add_to_streak("G",D)
	if(check_streak(A,D))
		return 1
	D.grabbedby(A,1)
	var/obj/item/grab/G = A.get_active_hand()
	if(G && prob(50))
		G.state = GRAB_AGGRESSIVE
		D.visible_message(SPAN_DANGER("[A] gets a strong grip on [D]!"))
	return 1

/datum/martial_art/kis_khan/harm_act(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	add_to_streak("H",D)
	if(check_streak(A,D))
		return 1
	basic_hit(A,D)
	return 1

/datum/martial_art/kis_khan/disarm_act(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	add_to_streak("D",D)
	if(check_streak(A,D))
		return 1
	if(istype(D, /mob/living/simple_animal))
		simple_animal_basic_disarm(A,D)
	else
		basic_hit(A,D)
	return 1

/datum/martial_art/kis_khan/simple_animal_basic_disarm(var/mob/living/carbon/human/A, var/mob/living/simple_animal/D)
	if(!D.paralysis)
		A.visible_message("[SPAN_BOLD("[A]")] delivers a blow to \the [SPAN_BOLD("[D]")]'s head, making [D.get_pronoun("him")] fall unconscious!")
		A.do_attack_animation(D)
		playsound(D.loc, /singleton/sound_category/punch_sound, 25, TRUE, MEDIUM_RANGE_SOUND_EXTRARANGE+4)
		D.AdjustParalysis(5)
	else
		to_chat(A, SPAN_WARNING("\The [SPAN_BOLD("[D]")] is already unconscious!"))
		return

/datum/martial_art/kis_khan/proc/tail_sweep(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	if(D.stat || D.weakened)
		return 0
	if(!isunathi(A))
		return 0
	TornadoAnimate(A)
	A.visible_message(SPAN_WARNING("[A] sweeps [D] with their tail!"))
	playsound(get_turf(A), /singleton/sound_category/swing_hit_sound, 50, 1, -1)
	D.apply_damage(5, DAMAGE_BRUTE)
	D.Weaken(2)
	return 1

/datum/martial_art/kis_khan/proc/swift_disarm(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	A.do_attack_animation(D)
	if(prob(80))
		if(D.hand)
			if(istype(D.l_hand, /obj/item))
				var/obj/item/I = D.l_hand
				D.drop_item()
				A.put_in_hands(I)
		else
			if(istype(D.r_hand, /obj/item))
				var/obj/item/I = D.r_hand
				D.drop_item()
				A.put_in_hands(I)
		D.visible_message(SPAN_DANGER("[A] has disarmed [D]!"))
		playsound(D, 'sound/weapons/thudswoosh.ogg', 50, 1, -1)
	else
		D.visible_message(SPAN_DANGER("[A] attempted to disarm [D]!"))
		playsound(D, /singleton/sound_category/punchmiss_sound, 25, 1, -1)
	return 1

/datum/martial_art/kis_khan/proc/hammering_strike(var/mob/living/carbon/human/A, var/mob/living/carbon/human/D)
	A.do_attack_animation(D)
	A.visible_message(SPAN_DANGER("[A] slams [D] away!"))
	playsound(D.loc, "punch", 50, 1, -1)
	D.apply_effect(2, WEAKEN)
	var/atom/throw_target = get_edge_target_turf(D, get_dir(D, get_step_away(D, A)))
	D.throw_at(throw_target, 200, 4,A)

/datum/martial_art/kis_khan/proc/kis_khan_help()
	set name = "Recall Kis-khan"
	set desc = "Remember the martial techniques of the Kis-khan."
	set category = "Abilities"

	to_chat(usr, "<b><i>You hiss deeply and remember the traditions...</i></b>")
	to_chat(usr, "<span class='notice'>Tail Sweep</span>: Harm Harm Disarm. Trips the victim with your tail, rendering them prone and unable to move for a short time.")
	to_chat(usr, "<span class='notice'>Swift Disarm</span>: Disarm Disarm Grab. Strikes your target's weapon, trying to disarm it from their hands.")
	to_chat(usr, "<span class='notice'>Hammering Strike</span>: Disarm Harm Disarm. Delivers a strikes that will push the target away from you.")
	to_chat(usr, "<span class='notice'>You can also deal a knockout blow to non-sapient animals by using disarm.</span>")

/obj/item/martial_manual/unathi
	name = "kis khan scroll"
	desc = "A parched scroll.It seems to be drawings of some sort of martial art involving tails."
	icon_state = "scroll"
	item_state = "scroll"
	martial_art = /datum/martial_art/kis_khan
	species_restriction = list(SPECIES_UNATHI)

#undef TAIL_SWEEP
#undef SWIFT_DISARM
#undef HAMMERING_STRIKE
