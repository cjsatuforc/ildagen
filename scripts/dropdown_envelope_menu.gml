ddobj = instance_create(mouse_x,mouse_y,oDropDown);
with (ddobj)
    {
    num = 5;
    event_user(1);
    ds_list_add(desc_list,"Toggle Minimize/Hide");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_env_hide);
    ds_list_add(hl_list,ds_list_find_value(seqcontrol.selectedenvelope,4));
    ds_list_add(desc_list,"Change Type");
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dropdown_envelope_type);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Toggle Disable/Mute")
    ds_list_add(sep_list,0);
    ds_list_add(scr_list,dd_seq_env_disable);
    ds_list_add(hl_list,ds_list_find_value(seqcontrol.selectedenvelope,3));
    ds_list_add(desc_list,"Clear data");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_env_clear);
    ds_list_add(hl_list,1);
    ds_list_add(desc_list,"Delete Envelope");
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_seq_env_delete);
    ds_list_add(hl_list,1);
    }
