/datum/computer_file/program/crushercontrol
	filename = "crushercontrol"
	filedesc = "Crusher Control"
	extended_desc = "Application to Control the Crusher"
	program_icon_state = "command"
	program_key_icon_state = "green_key"
	size = 8
	requires_ntnet = FALSE
	available_on_ntnet = FALSE
	required_access_run = list(ACCESS_JANITOR, ACCESS_PARAMEDIC)
	required_access_download = ACCESS_HOP
	requires_access_to_run = PROGRAM_ACCESS_LIST_ONE
	usage_flags = PROGRAM_TELESCREEN
	tgui_id = "CrusherControl"
	var/message = "" // Message to return to the user
	var/extending = FALSE //If atleast one of the pistons is extending
	var/list/pistons = list() //List of pistons linked to the program
	var/list/airlocks = list() //List of airlocks linked to the program
	var/list/status_pistons = list() //Status of the pistons

/datum/computer_file/program/crushercontrol/ui_data(mob/user)
	var/list/data = initial_data()

	status_pistons = list()
	extending = FALSE

	//Cycle through the pistons and get their status
	var/i = 1
	for(var/obj/machinery/crusher_base/pstn in pistons)
		var/num_progress = pstn.get_num_progress()
		var/is_blocked = pstn.is_blocked()
		var/action = pstn.get_action()
		if(action == "extend")
			extending = TRUE
		status_pistons.Add(list(list(
			"progress"=num_progress,
			"blocked"=is_blocked,
			"action"=action,
			"piston"=i
			)))
		i++

	data["message"] = message
	data["airlock_count"] = airlocks.len
	data["piston_count"] = pistons.len
	data["status_pistons"] = status_pistons
	data["extending"] = extending

	return data

/datum/computer_file/program/crushercontrol/ui_act(action, list/params, datum/tgui/ui, datum/ui_state/state)
	. = ..()
	if(..())
		return

	switch(action)
		if("initialize")
			pistons = list()
			for(var/obj/machinery/crusher_base/pstn in orange(10, ui_host()))
				pistons += pstn

			airlocks = list()
			for(var/obj/machinery/door/airlock/arlk in orange(10, ui_host()))
				if(arlk.id_tag != "compactor_access")
					continue
				airlocks += arlk

			airlock_open()
			. = TRUE

		if("hatch_open")
			message = "Opening the Hatch"
			airlock_open()
			. = TRUE

		if("hatch_close")
			message = "Closing the Hatch"
			airlock_close()
			. = TRUE

		if("crush")
			message = "Crushing"
			airlock_close()
			crush_start()
			. = TRUE

		if("abort")
			message = "Aborting"
			crush_stop()
			. = TRUE

		if("close")
			message = null
			. = TRUE


/datum/computer_file/program/crushercontrol/proc/airlock_open()
	for(var/thing in airlocks)
		var/obj/machinery/door/airlock/arlk = thing
		if(!arlk.cur_command)
			// Not using do_command so that the command queuer works.
			arlk.cur_command = "secure_open"
			arlk.execute_current_command()

/datum/computer_file/program/crushercontrol/proc/airlock_close()
	for(var/thing in airlocks)
		var/obj/machinery/door/airlock/arlk = thing
		if(!arlk.cur_command)
			arlk.cur_command = "secure_close"
			arlk.execute_current_command()

/datum/computer_file/program/crushercontrol/proc/crush_start()
	for(var/obj/machinery/crusher_base/pstn in pistons)
		pstn.crush_start()

/datum/computer_file/program/crushercontrol/proc/crush_stop()
	for(var/obj/machinery/crusher_base/pstn in pistons)
		pstn.crush_abort()
