ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 8;
    event_user(1);
    ds_list_add(desc_list,"Select type:");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,doc_list);//do nothing
    ds_list_add(hl_list,1);
    ds_list_add(sep_list,1);
    
    ds_list_add(desc_list,"X (Horizontal displacement)");
    ds_list_add(desc_list,"Y (Vertical displacement)");
    ds_list_add(desc_list,"Intensity (Alpha)");
    ds_list_add(desc_list,"Color Hue");
    ds_list_add(desc_list,"Red Color Channel");
    ds_list_add(desc_list,"Green Color Channel");
    ds_list_add(desc_list,"Blue Color Channel");
    repeat (6)
        ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_seq_envtype_x_create);
    ds_list_add(scr_list,dd_seq_envtype_y_create);
    ds_list_add(scr_list,dd_seq_envtype_a_create);
    ds_list_add(scr_list,dd_seq_envtype_hue_create);
    ds_list_add(scr_list,dd_seq_envtype_r_create);
    ds_list_add(scr_list,dd_seq_envtype_g_create);
    ds_list_add(scr_list,dd_seq_envtype_b_create);
    repeat (7)
        ds_list_add(hl_list,1);
    }