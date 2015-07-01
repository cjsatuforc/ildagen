ddobj = instance_create(controller.menu_width_start[0],0,oDropDown);
with (ddobj)
    {
    num = 6;
    event_user(1);
    ds_list_add(desc_list,"New (Clear)");
    ds_list_add(desc_list,"Save LasershowGen frames file");
    ds_list_add(desc_list,"Load LasershowGen frames file");
    ds_list_add(desc_list,"Export ILDA file");
    ds_list_add(desc_list,"Import ILDA file");
    ds_list_add(desc_list,"Send frames to timeline mode");
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(sep_list,0);
    ds_list_add(sep_list,1);
    ds_list_add(scr_list,dd_ilda_clear);
    ds_list_add(scr_list,dd_ilda_saveframes);
    ds_list_add(scr_list,dd_ilda_loadframes);
    ds_list_add(scr_list,dd_ilda_exportilda);
    ds_list_add(scr_list,dd_ilda_importilda);
    ds_list_add(scr_list,frames_toseq);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,1);
    ds_list_add(hl_list,(seqcontrol.selectedlayer != -1));
    }
