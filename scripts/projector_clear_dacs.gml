var t_thisdaclist = ds_list_find_value(seqcontrol.projector_list[| settingscontrol.projectortoselect], 2);
for (i = 0; i < ds_list_size(t_thisdaclist); i++)
    ds_list_destroy(t_thisdaclist[| i]);
ds_list_clear(t_thisdaclist);

projectorlist_update();
