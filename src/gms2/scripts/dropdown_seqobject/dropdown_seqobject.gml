ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-23,"foreground",obj_dropdown);
with (ddobj)
    {
    num = 6;
    event_user(1);
    ds_list_add(desc_list,"Cut (Ctrl+X)");
    ds_list_add(desc_list,"Copy (Ctrl+C)");
    ds_list_add(desc_list,"Delete (Del)");
    ds_list_add(desc_list,"Open in frame editor");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,seq_cut_object);
    ds_list_add(scr_list,seq_copy_object);
    ds_list_add(scr_list,seq_delete_object);
    ds_list_add(scr_list,seq_edit_object);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
	ds_list_add(desc_list,"Reverse");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,reverse_timelineobject);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Change duration");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_seq_object_duration);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Split here (S)");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,split_timelineobject_dropdown);
    ds_list_add(hl_list,1);
    }
