/datum/ghostspawner/human/tirakqi_crew
	short_name = "tirakqi_crew"
	name = "Ti'Rakqi Lu'fup"
	desc = "You crew the ship, mop the floors, cook the meals, and shoot whoever gets too close to the goods. Try to show some initiative!"
	desc_ooc = "Lu'fup who spawn as Vaurcae should have backgrounds consistent with that of the Xi'larx!"
	tags = list("External")

	spawnpoints = list("tirakqi_crew")
	max_count = 2

	outfit = /obj/outfit/admin/tirakqi_crew
	possible_species = list(SPECIES_SKRELL, SPECIES_SKRELL_AXIORI, SPECIES_VAURCA_WORKER, SPECIES_VAURCA_WARRIOR, SPECIES_DIONA, SPECIES_DIONA_COEUS)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Ti'Rakqi Lu'fup"
	special_role = "Ti'Rakqi Lu'fup"
	respawn_flag = null

	uses_species_whitelist = FALSE
	uses_species_whitelist_override = list(FALSE, FALSE, FALSE, TRUE, FALSE, FALSE)

/obj/outfit/admin/tirakqi_crew
	name = "Ti'Rakqi Lu'fup"

	uniform = list(
		/obj/item/clothing/under/skrell/nralakk/ox/service,
		/obj/item/clothing/under/skrell/nralakk/ox/engineer,
		/obj/item/clothing/under/skrell/wetsuit/tirakqi/teal,
		/obj/item/clothing/under/skrell/wetsuit/tirakqi/blue,
		/obj/item/clothing/under/skrell/wetsuit/tirakqi/pink,
		/obj/item/clothing/under/skrell/wetsuit/tirakqi/purple
		)

	suit = list(
		/obj/item/clothing/suit/storage/toggle/leather_jacket/flight/green,
		/obj/item/clothing/suit/storage/toggle/leather_jacket/flight/white,
		/obj/item/clothing/suit/storage/toggle/highvis,
		/obj/item/clothing/suit/storage/toggle/skrell/ox/service,
		/obj/item/clothing/suit/storage/toggle/skrell/ox/engineer
	)

	shoes = list(
		/obj/item/clothing/shoes/jackboots,
		/obj/item/clothing/shoes/workboots/brown,
		/obj/item/clothing/shoes/combat
	)

	head = list(
		/obj/item/clothing/head/skrell/skrell_bandana/tirakqi/teal,
		/obj/item/clothing/head/skrell/skrell_bandana/tirakqi/blue,
		/obj/item/clothing/head/skrell/skrell_bandana/tirakqi/pink,
		/obj/item/clothing/head/skrell/skrell_bandana/tirakqi/purple,
		/obj/item/clothing/ears/skrell/workcap/tirakqi/cyan,
		/obj/item/clothing/ears/skrell/workcap/tirakqi/pink,
		/obj/item/clothing/ears/skrell/workcap/tirakqi/purple
	)

	back = /obj/item/storage/backpack/satchel

	id = /obj/item/card/id

	l_ear = /obj/item/device/radio/headset/ship

	backpack_contents = list(/obj/item/storage/box/survival = 1)

/obj/outfit/admin/tirakqi_crew/get_id_access()
	return list(ACCESS_SKRELL, ACCESS_EXTERNAL_AIRLOCKS)

/obj/outfit/admin/tirakqi_crew/post_equip(mob/living/carbon/human/H, visualsOnly = FALSE)
	. = ..()
	if(isskrell(H))
		H.h_style = pick("Headtails", "Headtails", "Long Headtails", "Short Headtails", "Very Short Headtails", "Short Headtails, tucked", "Short Headtails, slicked", "Headtails, behind")
		H.f_style = pick("Shaved", "Shaved", "Shaved", "Shaved", "Tuux Chin Patch", "Tuux Chops", "Tuux Tri-Point", "Tuux Monotail")

		H.r_skin = pick(50, 80, 100, 120, 140, 170)
		H.g_skin = pick(50, 80, 100, 120, 140, 170)
		H.b_skin = pick(50, 80, 100, 120, 140, 170)

		H.r_hair = H.r_skin - pick(0, 10, 20, 30)
		H.g_hair = H.g_skin - pick(0, 10, 20, 30)
		H.b_hair = H.b_skin - pick(0, 10, 20, 30)

		H.r_facial = H.r_hair
		H.g_facial = H.g_hair
		H.b_facial = H.b_hair
	if(isvaurca(H))
		H.equip_to_slot_or_del(new /obj/item/clothing/mask/gas/vaurca/filter(H), slot_wear_mask)
		var/obj/item/organ/internal/vaurca/preserve/preserve = H.internal_organs_by_name[BP_PHORON_RESERVE]
		H.internal = preserve
		H.internals.icon_state = "internal1"
		H.equip_or_collect(new /obj/item/reagent_containers/inhaler/phoron_special, slot_in_backpack)
		H.update_body()

/datum/ghostspawner/human/tirakqi_captain
	short_name = "tirakqi_captain"
	name = "Ti'Rakqi Qu'qrot"
	desc = "Lead the Lu'fup and Qu'oot under your command. Smuggle, cheat, lie, and profit. You've got a crew and a ship to maintain."
	tags = list("External")

	spawnpoints = list("tirakqi_captain")
	max_count = 1

	outfit = /obj/outfit/admin/tirakqi_crew/captain
	possible_species = list(SPECIES_SKRELL, SPECIES_SKRELL_AXIORI)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Ti'Rakqi Qu'qrot"
	special_role = "Ti'Rakqi Qu'qrot"
	respawn_flag = null

	uses_species_whitelist = TRUE

/obj/outfit/admin/tirakqi_crew/captain
	name = "Ti'Rakqi Qu'qrot"

	uniform = /obj/item/clothing/under/skrell/wetsuit/tirakqi/star

	head = /obj/item/clothing/head/skrell/skrell_bandana/tirakqi/captain
	suit = /obj/item/clothing/suit/storage/toggle/skrell/starcoat


/datum/ghostspawner/human/tirakqi_medic
	short_name = "tirakqi_medic"
	name = "Ti'Rakqi Medic"
	desc = "You're a trained doctor serving as a Qu'oot with the Ti'Rakqi! Try to keep the crew alive or you may find yourself stranded in space."
	tags = list("External")

	spawnpoints = list("tirakqi_medic")
	max_count = 1

	outfit = /obj/outfit/admin/tirakqi_crew/medic
	possible_species = list(SPECIES_SKRELL, SPECIES_SKRELL_AXIORI)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Ti'Rakqi Medic"
	special_role = "Ti'Rakqi Medic"
	respawn_flag = null

	uses_species_whitelist = TRUE

/obj/outfit/admin/tirakqi_crew/medic
	name = "Ti'Rakqi Medic"

	uniform = list(
		/obj/item/clothing/under/skrell/wetsuit/tirakqi/teal,
		/obj/item/clothing/under/skrell/wetsuit/tirakqi/blue
		)

	suit = /obj/item/clothing/suit/storage/toggle/labcoat
	glasses = /obj/item/clothing/glasses/hud/health


/datum/ghostspawner/human/tirakqi_engineer
	short_name = "tirakqi_engineer"
	name = "Ti'Rakqi Engineer"
	desc = "You're a trained engineer serving as a Qu'oot with the Ti'Rakqi! Try to keep the ship functioning or you may find yourself stranded in space."
	tags = list("External")

	spawnpoints = list("tirakqi_engineer")
	max_count = 1

	outfit = /obj/outfit/admin/tirakqi_crew/engineer
	possible_species = list(SPECIES_SKRELL, SPECIES_SKRELL_AXIORI)
	allow_appearance_change = APPEARANCE_PLASTICSURGERY

	assigned_role = "Ti'Rakqi Engineer"
	special_role = "Ti'Rakqi Engineer"
	respawn_flag = null

	uses_species_whitelist = TRUE

/obj/outfit/admin/tirakqi_crew/engineer
	name = "Ti'Rakqi Engineer"

	uniform = /obj/item/clothing/under/skrell/wetsuit/tirakqi/engineer
	suit = /obj/item/clothing/suit/storage/toggle/highvis_alt
	belt = /obj/item/storage/belt/utility/full
	gloves = /obj/item/clothing/gloves/yellow
