ilda_cancel();

with (controller) 
    {
    if (os_browser == browser_not_a_browser)
        export_ilda();
    else 
        ilda_dialog_string("exporthtml5","Enter the name of the ILDA file","example.ild");
    }
