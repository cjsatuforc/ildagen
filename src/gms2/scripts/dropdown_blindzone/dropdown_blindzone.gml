ddobj = instance_create_layer(window_mouse_get_x(), window_mouse_get_y()-23,"foreground",obj_dropdown);
with (ddobj)
    {
    num = 2;
    ds_list_add(desc_list,"Delete blind zone");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,blindzone_delete);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Clear all blind zones");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,blindzone_clear);
    ds_list_add(hl_list,1);
    event_user(1);
    }
