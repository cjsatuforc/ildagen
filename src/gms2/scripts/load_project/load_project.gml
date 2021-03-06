//loads project igp file
file_loc = argument0;
if !string_length(file_loc) 
    exit;
    
clear_project();

file_copy(file_loc, "temp/temp.igp");
load_buffer = buffer_load("temp/temp.igp");
    
idbyte = buffer_read(load_buffer,buffer_u8);
if (idbyte != 104) and (idbyte != 103) and (idbyte != 100) and (idbyte != 101) and (idbyte != 102)
{
    show_message_new("Unexpected ID byte, is this a valid LaserShowGen project file?");
    exit;
}
    
projectfps = buffer_read(load_buffer,buffer_u8);
songload = buffer_read(load_buffer,buffer_u8);
parsingaudioload = buffer_read(load_buffer,buffer_u8);
startframe = buffer_read(load_buffer,buffer_u32);
endframe = buffer_read(load_buffer,buffer_u32);
audioshift = buffer_read(load_buffer,buffer_s32);
loop = buffer_read(load_buffer,buffer_bool);
length = endframe+50;
buffer_seek(load_buffer,buffer_seek_start,50);

maxlayers = buffer_read(load_buffer,buffer_u32);
    
global.loadingtimeprev = get_timer();

global.loading_loadproject = 1;

global.loading_start = 0;
global.loading_end = maxlayers;
global.loading_current = global.loading_start;

room_goto(rm_loading);
