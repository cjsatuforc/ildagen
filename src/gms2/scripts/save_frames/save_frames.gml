//exports the frames from the ilda editor into an igf file
placing_status = 0;

file_loc = get_save_filename_ext("LSG frames|*.igf","example.igf","","Select LaserShowGen frames file location");
if !string_length(file_loc) 
    exit;
    
if (filename_ext(file_loc) != ".igf")
    show_message_new("Warning: Your filename has no .igf extension, and might not be recognized when trying to load it.\n\nIt is recommended to save the file again, with a the text .igf at the end of the name.");
    
save_buffer = buffer_create(1,buffer_grow,1);

buffer_write(save_buffer,buffer_u8,52);
buffer_write(save_buffer,buffer_u32,maxframes);

for (j = 0; j < maxframes;j++)
{
    el_list = ds_list_find_value(frame_list,j);
    buffer_write(save_buffer,buffer_u32,ds_list_size(el_list));
    
    for (i = 0; i < ds_list_size(el_list);i++)
    {
        ind_list = ds_list_find_value(el_list,i);
        tempsize = ds_list_size(ind_list);
        buffer_write(save_buffer,buffer_u32,tempsize);
        
        for (u = 0; u < 10; u++)
        {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
        }
        for (u = 10; u < 20; u++)
        {
            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u));
        }
        for (u = 20; u < tempsize; u += 4)
        {
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u));
            buffer_write(save_buffer,buffer_f32,ds_list_find_value(ind_list,u+1));
            buffer_write(save_buffer,buffer_bool,ds_list_find_value(ind_list,u+2));
            buffer_write(save_buffer,buffer_u32,ds_list_find_value(ind_list,u+3));
        }
    }
}
//remove excess size
buffer_resize(save_buffer,buffer_tell(save_buffer));

//export
buffer_save(save_buffer,file_loc);

var t_time = get_timer();
while ((get_timer() - t_time) > 4095)
    j = 0;
    
show_message_new("LaserShowGen frames saved to "+string(file_loc));

buffer_delete(save_buffer);
