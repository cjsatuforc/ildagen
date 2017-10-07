if (instance_exists(obj_dropdown))
    exit;
	
visible = !ds_list_empty(controller.semaster_list);
	
if (!visible)
	exit;
	
var i;
image_index = 0;
for (i = 0; i < ds_list_size(controller.semaster_list); i++)
{
	if (ds_list_find_value(controller.semaster_list[| i], 11) == true)
	{
		if (image_index == 1)
		{
			image_index = 2;
			break;
		}
		else
			image_index = 1;
	}
}
	
if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Enable to force the selected object to be drawn in its original point order. (Can reduce animation glitches)";
}