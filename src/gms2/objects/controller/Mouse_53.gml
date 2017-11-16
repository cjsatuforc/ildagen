if (room != rm_ilda) exit;
    
//menu
if (mouse_y < 0)   
{
    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
    {
        dropdown_menu_ilda_file();
    }
    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
    {
        dropdown_menu_ilda_properties();
    }
    else if (mouse_x > menu_width_start[2]) and (mouse_x < menu_width_start[3])
	{
        dropdown_menu_ilda_edit();
    }
    else if (mouse_x > menu_width_start[3]) and (mouse_x < menu_width_start[4])
    {
        dropdown_menu_ilda_tools();
    }
    else if (mouse_x > menu_width_start[4]) and (mouse_x < menu_width_start[5])
    {
        dropdown_menu_ilda_view();
    }
    else if (mouse_x > menu_width_start[5]) and (mouse_x < menu_width_start[6])
    {
        dropdown_menu_ilda_settings();
    }
    else if (mouse_x > menu_width_start[6]) and (mouse_x < menu_width_start[7])
    {
        dropdown_menu_ilda_about();
    }
    exit;
}

if (instance_exists(obj_dropdown)) or (mouse_x > view_wport[4]) or (mouse_y > view_wport[4]) or (keyboard_check(vk_control) or (placing == "select"))
    exit;

var t_scale = $ffff/view_wport[4];

if !ds_list_empty(semaster_list)  and (
((mouse_x == clamp(mouse_x,rectxmin/t_scale-2,rectxmax/t_scale+2)) and (mouse_y == clamp(mouse_y,rectymin/t_scale-2,rectymax/t_scale+2)))
or ((mouse_x == clamp(mouse_x,anchorx/t_scale-10,anchorx/t_scale+10)) and (mouse_y == clamp(mouse_y,anchory/t_scale-10,anchory/t_scale+10)))
or ((mouse_x == clamp(mouse_x,rectxmin/t_scale-20,rectxmin/t_scale-2)) and (mouse_y == clamp(mouse_y,rectymax/t_scale+2,rectymax/t_scale+20)))
or ((mouse_x == clamp(mouse_x,rectxmax/t_scale+2,rectxmax/t_scale+20)) and (mouse_y == clamp(mouse_y,rectymax/t_scale+2,rectymax/t_scale+20)))
)
    exit;
    
ds_list_clear(semaster_list);

if ((keyboard_check(ord("E"))) and (placing_status != 2))
{
    ds_list_add(undo_list,"bb"+string(color2));
    ds_list_add(undo_list,"b"+string(color1));
    color1 = draw_getpixel(obj_cursor.x,obj_cursor.y+23);
    update_colors();
    exit;
}

if ((mouse_x > view_wport[4]+3) or (mouse_y > view_wport[4]+3)) and (placing_status != 2)
{
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
    exit;
}
    
    
if (placing_status == 0)
{
    placing_status = 1;
    startpos[0] = obj_cursor.x/view_wport[4]*$ffff;
    startpos[1] = obj_cursor.y/view_wport[4]*$ffff;
    if (placing == "text")
        create_text_init();
    else if (placing == "free")
    {
        ds_list_add(free_list,0);
        ds_list_add(free_list,0);
    }
    else if (placing == "curve")
    {
        bezier_coeffs(0,0,0,0,0,0,0,0);
        ds_list_add(bez_list,startpos[0]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
        ds_list_add(bez_list,startpos[1]);
    }
}
    
else if (placing_status == 2) and (placing == "curve")
{
    if (point_distance(mouse_x,mouse_y,ds_list_find_value(bez_list,2)/$ffff*view_wport[4],ds_list_find_value(bez_list,3)/$ffff*view_wport[4]) < 7)
        bez_moving = 1;
    else if (point_distance(mouse_x,mouse_y,ds_list_find_value(bez_list,4)/$ffff*view_wport[4],ds_list_find_value(bez_list,5)/$ffff*view_wport[4]) < 7)
        bez_moving = 2;
    if (point_distance(mouse_x,mouse_y,ds_list_find_value(bez_list,0)/$ffff*view_wport[4],ds_list_find_value(bez_list,1)/$ffff*view_wport[4]) < 7)
        bez_moving = 3;
    else if (point_distance(mouse_x,mouse_y,ds_list_find_value(bez_list,6)/$ffff*view_wport[4],ds_list_find_value(bez_list,7)/$ffff*view_wport[4]) < 7)
        bez_moving = 4;
    mouse_yprevious = mouse_y;
    mouse_xprevious = mouse_x;
}

