ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 1;
    ds_list_add(desc_list,"Reset to full size");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,projectionwindow_reset);
    ds_list_add(hl_list,1);
    
    event_user(1);
    }
