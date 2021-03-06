if (debug_mode)
    log("output_framelist_to_buffer");
    
//var timerbm = get_timer();

output_buffer_next_size = min(ds_list_size(list_raw)/4, $ffff/controller.projectfps, 4095);
var t_list_raw_size = output_buffer_next_size*4;

var t_red_lowerbound = round(controller.red_scale_lower*255);
var t_green_lowerbound = round(controller.green_scale_lower*255);
var t_blue_lowerbound = round(controller.blue_scale_lower*255);
var t_red_scale = controller.red_scale*(255-t_red_lowerbound)/255;
var t_green_scale = controller.green_scale*(255-t_green_lowerbound)/255;
var t_blue_scale = controller.blue_scale*(255-t_blue_lowerbound)/255;

if (controller.exp_optimize)
{
    safe_bottom_boundary = abs(min(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift));
    safe_top_boundary = t_list_raw_size-max(controller.opt_redshift,controller.opt_greenshift,controller.opt_blueshift,controller.opt_blankshift);
    
    var t_blankshift = controller.opt_blankshift*4;
    var t_redshift = controller.opt_redshift*4;
    var t_greenshift = controller.opt_greenshift*4;
    var t_blueshift = controller.opt_blueshift*4;
    
    for (i = 0; i < t_list_raw_size; i += 4)
    {
        //writing point
        
		if (!controller.swapxy)
		{
	        if (controller.invert_x)
	            buffer_write(output_buffer,buffer_u16, $FFFF - list_raw[| i+0]);
	        else
	            buffer_write(output_buffer,buffer_u16, list_raw[| i+0]);
            
	        if (controller.invert_y)
	            buffer_write(output_buffer,buffer_u16, $FFFF - list_raw[| i+1]);
	        else
	            buffer_write(output_buffer,buffer_u16, list_raw[| i+1]);
		}
		else
		{
			if (controller.invert_y)
	            buffer_write(output_buffer,buffer_u16, $FFFF - list_raw[| i+1]);
	        else
	            buffer_write(output_buffer,buffer_u16, list_raw[| i+1]);
				
			if (controller.invert_x)
	            buffer_write(output_buffer,buffer_u16, $FFFF - list_raw[| i+0]);
	        else
	            buffer_write(output_buffer,buffer_u16, list_raw[| i+0]);
		}
            
        if ((i < safe_bottom_boundary) || (i > safe_top_boundary))
        {
            buffer_write(output_buffer,buffer_u32,0);
            buffer_write(output_buffer,buffer_u32,0);
        }
        else
        {
            buffer_write(output_buffer,buffer_u16,t_red_lowerbound + (list_raw[| i+t_redshift+3] & $FF) * t_red_scale);
            buffer_write(output_buffer,buffer_u16,t_green_lowerbound + ((list_raw[| i+t_greenshift+3] >> 8) & $FF) * t_green_scale);
            buffer_write(output_buffer,buffer_u16,t_blue_lowerbound + (list_raw[| i+t_blueshift+3] >> 16) * t_blue_scale);
            if (list_raw[| i+t_blankshift+2])
                buffer_write(output_buffer,buffer_u16,0); 
            else
                buffer_write(output_buffer,buffer_u16,255);
        }
    }
}
else //not optimized
{
    for (i = 0; i < t_list_raw_size; i += 4)
    {
        //writing point
        
        if (controller.invert_x)
            buffer_write(output_buffer,buffer_u16, $FFFF - list_raw[| i+0]);
        else
            buffer_write(output_buffer,buffer_u16, list_raw[| i+0]);
            
        if (controller.invert_y)
            buffer_write(output_buffer,buffer_u16, $FFFF - list_raw[| i+1]);
        else
            buffer_write(output_buffer,buffer_u16, list_raw[| i+1]);
        
        buffer_write(output_buffer,buffer_u16,t_red_lowerbound + (list_raw[| i+3] & $FF) * t_red_scale);
        buffer_write(output_buffer,buffer_u16,t_green_lowerbound + ((list_raw[| i+3] >> 8) & $FF) * t_green_scale);
        buffer_write(output_buffer,buffer_u16,t_blue_lowerbound + (list_raw[| i+3] >> 16) * t_blue_scale);
        if (list_raw[| i+2])
            buffer_write(output_buffer,buffer_u16,0); 
        else
            buffer_write(output_buffer,buffer_u16,255);
    }
}
    
ds_list_destroy(list_raw);

//log("output_framelist_to_buffer",get_timer() - timerbm);

