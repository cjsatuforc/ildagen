ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-23,"foreground",obj_dropdown);
with (ddobj)
    {
    num = 2;
    event_user(1);
    ds_list_add(desc_list,"Set font");
    ds_list_add(desc_list,"Set size");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_text_font);
    ds_list_add(scr_list,dd_text_size);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    }
    
