if (instance_exists(oDropDown))
    exit;
if (!visible)
    exit;

if (room == rm_seq)
{
    with (seqcontrol)
    {
        viewmode++;
        if (viewmode > 2)
            viewmode = 0;
        frame_surf_refresh = 1;
    }
}
else if (room == rm_ilda)
{
    with (controller)
    {
        viewmode++;
        if (viewmode > 2)
            viewmode = 0;
        frame_surf_refresh = 1;
    }
}

