if (instance_exists(obj_dropdown))
    exit;
if (!_visible)
	exit;
with (controller)
{
    placing_status = 0;
    ds_list_clear(free_list);
    ds_list_clear(bez_list);
}
    
dropdown_reap();

