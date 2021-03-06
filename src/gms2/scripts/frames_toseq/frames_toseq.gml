//sends editor frames to a timeline object
if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, the timeline is not available in the web version");
    exit;
}

if (!verify_serial(true))
    exit;

if (seqcontrol.selectedlayer = -1) or (ds_list_empty(seqcontrol.layer_list))
{
    show_message_new("No timeline position marked, enter timeline mode and select a position by clicking on a layer first.");
    exit;
}

ilda_cancel();
frame = 0;
framehr = 0;
    
//todo check for overlaps
/*with (seqcontrol)
{
    _layer = ds_list_find_value(layer_list,selectedlayer);
    for (j = 1; j < ds_list_size(_layer); j += 3)
    {
        infolist = ds_list_find_value(_layer,j+2);
        frametime = ds_list_find_value(_layer,j);
        if (selectedx+controller.maxframes = clamp(frametime,tlx,tlx+tlzoom)) 
        {
            //frametime-tlx
            //frametime-tlx+ds_list_find_value(infolist,0);
        }
    }
}*/

save_buffer = buffer_create(16,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,52);
buffer_write(save_buffer,buffer_u32,maxframes);

for (j = 0; j < maxframes;j++)
{
    el_list = ds_list_find_value(frame_list,j);
    buffer_write(save_buffer,buffer_u32,ds_list_size(el_list));
    
    for (i = 0; i < ds_list_size(el_list);i++)
    {
        ind_list = ds_list_find_value(el_list,i);
        buffer_write(save_buffer,buffer_u32,ds_list_size(ind_list));
        tempsize = ds_list_size(ind_list);
        
        for (u = 0; u < 10; u++)
        {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
        }
        for (u = 10; u < 20; u++)
        {
            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u));
        }
        for (u = 20; u < tempsize; u += 4)
        {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u+1));
            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u+2));
            buffer_write(save_buffer,buffer_u32,ds_list_find_value(ind_list,u+3));
        }
    }
}
//remove excess size
buffer_resize(save_buffer,buffer_tell(save_buffer));

//send to sequencer
with (seqcontrol)
{
    selectedlayerlist = ds_list_find_value(layer_list,selectedlayer);
        
    if (ds_list_empty(somaster_list) or (ds_list_size(somaster_list) > 1))
    {
        objectlist = ds_list_create();
        ds_list_add(objectlist,selectedx);
        ds_list_add(objectlist,controller.save_buffer);
        
        info = ds_list_create();
        ds_list_add(info,controller.maxframes-1);
        ds_list_add(info,-1);
        ds_list_add(info,controller.maxframes);
        ds_list_add(objectlist,info);
        ds_list_add(selectedlayerlist[| 1],objectlist);
        
        ds_list_add(somaster_list,objectlist);
        
        infolisttemp = info;
        selectedx += controller.maxframes;
    }
    else
    {
        objectlist = ds_list_find_value(somaster_list,0);
		if (!ds_exists(objectlist,ds_type_list))
		{
			ds_list_delete(somaster_list, 0);
			{
			    show_message_new("No timeline position marked, enter timeline mode and select a position by clicking on a layer first.");
			    room_goto(rm_seq);
				exit;
			}
		}
        if (buffer_exists(ds_list_find_value(objectlist,1)))
			buffer_delete(ds_list_find_value(objectlist,1));
        ds_list_replace(objectlist,1,controller.save_buffer);
        
        var infolist = ds_list_find_value(objectlist,2);
        if (surface_exists(ds_list_find_value(infolist,1)))
            surface_free(ds_list_find_value(infolist,1));
        ds_list_replace(infolist,1,-1);
        ds_list_replace(infolist,2,controller.maxframes);
        
        infolisttemp = infolist;
    }
        
    undolisttemp = ds_list_create();
    ds_list_add(undolisttemp,objectlist);
    ds_list_add(undo_list,"c"+string(undolisttemp));
}
    
with (seqcontrol)
{
    if (song != -1) 
		FMODGMS_Chan_PauseChannel(play_sndchannel);
    playing = 0;
	timeline_surf_length = 0;
}
    
room_goto(rm_seq);
