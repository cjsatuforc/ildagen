if (room != rm_options)
    exit;
//if (view_current != 3)
//	exit;
    
//menu
draw_set_colour(c_black);
draw_set_alpha(1);
var t_ypos = camera_get_view_y(view_camera[3]);
draw_text(0, t_ypos+4, menu_string);
if (mouse_y > t_ypos)   
{
    draw_set_colour(c_teal);
    if (mouse_x > menu_width_start[0]) and (mouse_x < menu_width_start[1])
    {
        draw_rectangle(menu_width_start[0], t_ypos+1,menu_width_start[1], t_ypos+20,1);
        draw_set_alpha(0.3);
        draw_rectangle(menu_width_start[0], t_ypos+1,menu_width_start[1], t_ypos+20,0);
    }
    else if (mouse_x > menu_width_start[1]) and (mouse_x < menu_width_start[2])
    {
        draw_rectangle(menu_width_start[1], t_ypos+1,menu_width_start[2], t_ypos+20,1);
        draw_set_alpha(0.3);
        draw_rectangle(menu_width_start[1], t_ypos+1,menu_width_start[2], t_ypos+20,0);
    }
    else if (mouse_x > menu_width_start[2]) and (mouse_x < menu_width_start[3])
    {
        draw_rectangle(menu_width_start[2], t_ypos+1,menu_width_start[3], t_ypos+20,1);
        draw_set_alpha(0.3);
        draw_rectangle(menu_width_start[2], t_ypos+1,menu_width_start[3], t_ypos+20,0);
    }
    draw_set_alpha(1);
}
    
gpu_set_blendenable(0);
with (obj_section1_parent)
{
	if (!transparent && !visible)
	{
		if (_visible)
			draw_self();
	}
}
with (obj_section0_parent)
{
	if (!transparent && !visible)
	{
		if (_visible)
			draw_self();
	}
}
gpu_set_blendenable(1);
