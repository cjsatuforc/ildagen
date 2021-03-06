if (instance_exists(obj_dropdown))
    exit;

if (os_browser != browser_not_a_browser)
{
    show_message_new("Sorry, this feature is not available in the web version yet");
    exit;
}

if (room == rm_ilda)
{
    ilda_dialog_yesno("loadfile","This will replace your current frames, all unsaved work will be lost. Continue? (Cannot be undone)");
}
else if (room == rm_seq)
{
    if (!verify_serial(true))
        exit;
    with (seqcontrol)
        load_frames_seq(get_open_filename_ext("LSG frames|*.igf","","","Select LaserShowGen frames file"));
}

