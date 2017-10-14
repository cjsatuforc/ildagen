if (instance_exists(obj_dropdown))
    exit;
if (moving == 1)
{
    controller.aniblank_offset = clamp((mouse_x-bbox_left)/128*360, 0, 360);
}
    
visible = (controller.blankmode != "solid")  and (controller.blankmode != "func") and (controller.anienable);
if (!visible)
    exit;

if (mouse_x > bbox_left) and (mouse_x < bbox_right) and (mouse_y > bbox_top) and ((mouse_y < bbox_bottom))
{
    controller.tooltip = "Changes the blanking periodic offset at end of animation.";
} 

