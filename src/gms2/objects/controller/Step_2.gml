if (ex_patch_window_close_event())
    exit_confirm();
    
if (keyboard_check_pressed(ord("M")))
{
    window_set_fullscreen(0);
    window_set_size(default_window_w, default_window_h);
}
else if (keyboard_check_released(vk_f11))
    window_set_fullscreen(!window_get_fullscreen());
    
if (room == rm_loading)
{
    if (global.loading_exportilda == 1)
        export_ilda_work();
    else if (global.loading_exportildahtml5 == 1)
        export_ilda_html5_work();
    else if (global.loading_importilda == 1)
    {
        if (global.loading_current < global.loading_end)
            read_ilda_work();
        else
            import_ilda_end();
    }
    else if (global.loading_importfont == 1)
    {
        if (global.loading_current < global.loading_end)
            read_ilda_work();
        else
            import_font_end();
    }
}
    
if (room == rm_ilda) && (keyboard_check(ord("Z")) && !keyboard_check(vk_control))
{
	obj_cursor.x = mouse_x;
	obj_cursor.y = mouse_y-camera_get_view_y(view_camera[4]);
	view_visible[5] = true;
	view_xport[5] = clamp(window_mouse_get_x()-128, 0, view_wport[4]-256);
	view_yport[5] = clamp(window_mouse_get_y()-23-128, 0, view_wport[4]-256);
	camera_set_view_pos(view_camera[5], window_mouse_get_x()-24, camera_get_view_y(view_camera[4])+window_mouse_get_y()-23-24);
}
else
{
	obj_cursor.x = window_mouse_get_x();
	obj_cursor.y = window_mouse_get_y()-23;
	view_visible[5] = false;
}

if (room != rm_ilda) 
	exit;
	
if (window_get_height() != (view_hport[3]+view_hport[4]+view_hport[1]) || window_get_width() != view_wport[3])
&& !(window_get_height() == 0 || window_get_width() == 0)
|| forceresize
{
	//if (window_get_height() < default_window_h || window_get_width() < default_window_w)
	//	window_set_size(default_window_w, default_window_h);
		
	log("Resized window");
	forceresize = false;
	
	view_hport[4] = max(window_get_height()-view_hport[1]-view_hport[3], 1);
	tlh = round(view_hport[4]/(512/44));
	view_wport[4] = max(view_hport[4]-tlh-1, 1);
	tlw = view_wport[4];
	view_wport[0] = window_get_width()-view_wport[4];
	if false //(view_wport[0] < 788)
	{
		window_set_size(default_window_w, default_window_h);
	
		view_hport[4] = window_get_height()-view_hport[1]-view_hport[3];
		tlw = view_wport[4];
		tlh = round(view_hport[4]/(512/42));
		view_wport[4] = view_hport[4]-tlh-1;
	}
	view_wport[3] = window_get_width();
	view_hport[0] = 706;
	view_hport[1] = 149;
	view_hport[6] = max(window_get_height()-view_hport[3]-view_hport[0], 1);
	view_wport[6] = view_wport[0];
	view_wport[1] = view_wport[4];
	view_yport[1] = view_hport[4]+view_hport[3];
	view_yport[6] = view_hport[3]+view_hport[0];
	camera_set_view_size(view_camera[0], max(view_wport[0],788), view_hport[0]);
	camera_set_view_size(view_camera[3], view_wport[3], view_hport[3]);
	camera_set_view_size(view_camera[4], view_wport[4], view_hport[4]);
	camera_set_view_size(view_camera[1], max(view_wport[1],512), view_hport[1]);
	camera_set_view_size(view_camera[6], view_wport[6], view_hport[6]);
	view_xport[0] = view_wport[4];
	view_xport[6] = view_xport[0];
	camera_set_view_pos(view_camera[6], 512, view_yport[6]-view_hport[3]);
	tlorigo_y = camera_get_view_y(view_camera[4])+view_hport[4]-tlh;
	
	free_scalable_surfaces();
}

el_list = frame_list[| frame];

if (placing == "hershey")
    hershey_handle_scroll();
    
object_select_hovering = 0;

check_mouseactions();

if (keyboard_check_pressed(vk_space))
{
    playing = !playing;
    if (seqcontrol.song != -1)
    {
        if (playing)
        {
			FMODGMS_Chan_ResumeChannel(seqcontrol.play_sndchannel);
            fmod_set_pos(seqcontrol.play_sndchannel,clamp((tlx+framehr)/seqcontrol.projectfps*1000, 0, seqcontrol.songlength));
        }
        else
            FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
    }
    
    if (!playing)
        refresh_minitimeline_flag = 1;
}
    
else if (keyboard_check_pressed(vk_backspace))
{
    deselect_object();
}
    
else if (keyboard_check(vk_control) && keyboard_check_pressed(ord("Z")))
{
    undo_ilda();
}
        
else if (keyboard_check_pressed(ord("0")))
{
    ilda_cancel();
    frame = 0;
    framehr = 0;
    refresh_minitimeline_flag = 1;
}
    
else if (keyboard_check_pressed(ord("P")))
{
    viewmode++;
    if (viewmode > 2)
        viewmode = 0;
    frame_surf_refresh = 1;
}

else if (keyboard_check_pressed(vk_escape))
{
    ds_list_clear(semaster_list);
        
    if (laseron)
    {
        laseron = false;
        frame_surf_refresh = true;
        dac_blank_and_center(dac);
    }
}
    
else if (keyboard_check(vk_control) || (placing == "select") || (highlight)) && ds_list_size(el_list)
{
    check_elementselect();
}

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("A")))
{
    dd_ilda_selectall();
}
    
//PASTE
if (keyboard_check(vk_control) && keyboard_check_pressed(ord("V")))
{
    paste_object();
}
    
if (keyboard_check(ord("S"))) || (sgridshow == 1)
{
    with (obj_cursor)
    {
        if (x < view_wport[4]) && (y < view_wport[4])
            move_snap(view_wport[4]/controller.sgridnum, view_wport[4]/controller.sgridnum);
    }
}

if (ds_list_size(el_list) > 0)
{
    if (keyboard_check(vk_alt) && (placing_status == 0))
    {
        if (keyboard_check(vk_control))
        {
            obj_cursor.x = ds_list_find_value(ds_list_find_value(el_list,ds_list_size(el_list)-1),0)/$ffff*view_wport[4];
            obj_cursor.y = ds_list_find_value(ds_list_find_value(el_list,ds_list_size(el_list)-1),1)/$ffff*view_wport[4];
        }
        else
        {
            obj_cursor.x = ds_list_find_value(ds_list_find_value(el_list,ds_list_size(el_list)-1),2)/$ffff*view_wport[4];
            obj_cursor.y = ds_list_find_value(ds_list_find_value(el_list,ds_list_size(el_list)-1),3)/$ffff*view_wport[4];
        }
    }
    else if (keyboard_check(ord("Q")))
    {
        nearestdist = 32;
        for (i = 0;i < ds_list_size(el_list);i++)
        {
            templist =  ds_list_find_value(el_list,i);
            if (point_distance(ds_list_find_value(templist,0)/$ffff*view_wport[4],ds_list_find_value(templist,1)/$ffff*view_wport[4],mouse_x,mouse_y) < nearestdist)
            {
                obj_cursor.x = ds_list_find_value(templist,0)/$ffff*view_wport[4];
                obj_cursor.y = ds_list_find_value(templist,1)/$ffff*view_wport[4];
                nearestdist = point_distance(ds_list_find_value(templist,0)/128,ds_list_find_value(templist,1)/$ffff*view_wport[4],mouse_x,mouse_y);
            }
            if (point_distance(ds_list_find_value(templist,2)/$ffff*view_wport[4],ds_list_find_value(templist,3)/128,mouse_x,mouse_y) < nearestdist)
            {
                obj_cursor.x = ds_list_find_value(templist,2)/$ffff*view_wport[4];
                obj_cursor.y = ds_list_find_value(templist,3)/$ffff*view_wport[4];
                nearestdist = point_distance(ds_list_find_value(templist,2)/$ffff*view_wport[4],ds_list_find_value(templist,3)/$ffff*view_wport[4],mouse_x,mouse_y);
            }
        }
        
    }
}
    
if (!surface_exists(frame_surf) || (!surface_exists(frame3d_surf) && viewmode != 0) || (highlight != keyboard_check(ord("H"))))
    frame_surf_refresh = true;

highlight = keyboard_check(ord("H"));
    
//SELECTED ELEMENT STUFFS
canrightclick = 1;
if !ds_list_empty(semaster_list)
{
    canrightclick = !handle_trans();
    
    //COPY
    if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C")))
    {
        copy_object();
    }
        
    //CUT
    else if (keyboard_check(vk_control) && keyboard_check_pressed(ord("X")))
    {
        cut_object();
    }
        
    //DELETE
    else if (keyboard_check_pressed(vk_delete))
    {
        delete_object();
    }
}

if	(window_mouse_get_x() == clamp(window_mouse_get_x(),0,view_wport[4])) && 
	(window_mouse_get_y()-23  == clamp(window_mouse_get_y()-23,0,view_wport[4])) &&
	(mouse_check_button_pressed(mb_right)) && (canrightclick)
		dropdown_empty();
    
//KEYBOARD RIGHT LEFT
if (keyboard_check(vk_left)) && (maxframes > 1) && (placing_status == 0)
{
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    
    if (keyboard_check_pressed(vk_left))
    {
        frame--;
        framehr--;
        scroll = 0;
        alarm[0] = 30;
    }
    else if (scroll)
        framehr -= delta_time/1000000*seqcontrol.projectfps;
    if (framehr < -0.5)
        framehr+= maxframes;
    frame = clamp(round(framehr),0,maxframes-1);
	if (frame != frameprev)
	{
        frame_surf_refresh = 1;
		update_semasterlist_flag = 1;
		refresh_minitimeline_flag = 1;
	}
}
else if (keyboard_check(vk_right)) && (maxframes > 1) && (placing_status == 0)
{
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    
    if (keyboard_check_pressed(vk_right))
    {
        frame++;
        framehr++;
        scroll = 0;
        alarm[0] = 30;
    }
    else if (scroll)
        framehr += delta_time/1000000*seqcontrol.projectfps;
    if (framehr > (maxframes-0.5))
        framehr -= maxframes;
	//log(frame, framehr, maxframes, maxframes-0.5);
    frame = clamp(round(framehr),0,maxframes-1);
    if (frame != frameprev)
	{
        frame_surf_refresh = 1;
		update_semasterlist_flag = 1;
		refresh_minitimeline_flag = 1;
	}
}


    
if (frame >= maxframes)
{
    frame = maxframes-1;
    framehr = maxframes-1;
}

//todo remove when fix for buffer loaded floats->int
maxframes = real(maxframes);
    
frameprev = frame;    

//guidelines
if (keyboard_check(ord("A")) || (guidelineshow == 1))
{
    if  (keyboard_check_pressed(ord("A")))
    {
        if (guidelinedouble == 1)
            guidelineshow = !guidelineshow;
        alarm[5] = 30;
        guidelinedouble = 1;
    }
}
   
//grids 
if (keyboard_check(ord("S")) || (sgridshow == 1))
{
    if  (keyboard_check_pressed(ord("S")))
    {
        if (sgriddouble == 1)
            sgridshow = !sgridshow;
        alarm[2] = 30;
        sgriddouble = 1;
    }
    if (keyboard_check_pressed(vk_up))
    {
        controller.sgridnum -= 1;
        if (controller.sgridnum < 1)
            controller.sgridnum = 1;
        square_grid_refresh();
    }
    if (keyboard_check_pressed(vk_down))
    {
        controller.sgridnum += 1;
        square_grid_refresh();
    }
} 
if (keyboard_check(ord("R")) || (rgridshow == 1))
{
    if  (keyboard_check_pressed(ord("R")))
    {
        if (rgriddouble == 1)
            rgridshow = !rgridshow;
        alarm[1] = 30;
        rgriddouble = 1;
    }
}

if (keyboard_check_pressed(vk_tab))
{
    if (os_browser != browser_not_a_browser)
    {
        show_message_new("Sorry, the timeline is not available in the web version yet");
        exit;
    }
    ilda_cancel();
    frame = 0;
    framehr = 0;
    if (seqcontrol.song != -1)
        FMODGMS_Chan_PauseChannel(seqcontrol.play_sndchannel);
        
    room_goto(rm_seq);
}

if (update_semasterlist_flag)
    update_semasterlist();