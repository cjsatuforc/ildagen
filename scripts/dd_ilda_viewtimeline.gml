if (room == rm_seq) exit;

if (os_browser != browser_not_a_browser)
    {
    show_message_async("Sorry, this timeline is not available in the web version");
    exit;
    }
    
placing_status = 0;
ds_list_clear(free_list);
ds_list_clear(bez_list);
playing = 0;
frame = 0;
framehr = 0;
if (seqcontrol.song)
    FMODInstanceSetPaused(seqcontrol.songinstance,1);
    
room_goto(rm_seq);
