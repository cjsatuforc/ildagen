if (!frame_surf_refresh)
    exit;
    
if (output_buffer_ready)
{
    if (output_buffer != -1)
        buffer_delete(output_buffer);
    output_buffer = output_buffer_next;
    dac_send_frame(dac, output_buffer, output_buffer_next_size);
    output_buffer_ready = false;
    frame_surf_refresh = false;
}

maxpoints = 0;

el_list = ds_list_find_value(frame_list,(frame+1) % (maxframes));
output_buffer_next = buffer_create(26664,buffer_fixed,1);

if (!ds_list_size(el_list)) 
{
    optimize_middle_output();
}
else
{
    if (output_makeframe_pass_list() == 0)
    {
        optimize_middle_output();
    }
}

output_makeframe_pass_int();
    
output_framelist_to_buffer();

hey = 1;

output_buffer_ready = true;

