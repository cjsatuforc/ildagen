//scans for available dacs (and resets all)

if (os_browser != browser_not_a_browser)
{
    show_message_async("Sorry, DAC connectivity is not available in the web version");
    exit;
}

controller.laseron = false;
controller.dac = -1;
numofdacs = dacwrapper_scandevices();

//cleanup
for (i = 0; i < ds_list_size(controller.dac_list); i++)
{
    var t_dac = controller.dac_list[| i];
    if (ds_exists(t_dac, ds_type_list))
    {
        if (buffer_exists(t_dac[| 4]))
            buffer_delete(t_dac[| 4]);
        if (buffer_exists(t_dac[| 5]))
            buffer_delete(t_dac[| 5]);
        ds_list_destroy(t_dac);
    }
}

ds_list_clear(controller.dac_list);

for (i = 0; i < numofdacs; i++)
{
    var t_result = dacwrapper_opendevice(i);
    if (!t_result)
        continue;
        
    var newdac = ds_list_create();
    ds_list_add(newdac,i);
    ds_list_add(newdac,dacwrapper_getname(i));
    ds_list_add(newdac,-1);
    ds_list_add(newdac,dacwrapper_getfirmware(i));
    ds_list_add(newdac,buffer_create(48000,buffer_fixed,2));
    ds_list_add(newdac,buffer_create(48000,buffer_fixed,2));
    ds_list_add(newdac,false);
    ds_list_add(newdac,0);
    ds_list_add(controller.dac_list,newdac);
}

if (ds_list_size(controller.dac_list) == 1)
    dac_select(0);

if (room == rm_options)
    surface_free(obj_dacs.surf_daclist);
