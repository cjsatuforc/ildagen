
if (!verify_serial(true))
    exit;

seq_dialog_yesno("loadproject","This will replace your current project, all unsaved work will be lost. Continue? (Cannot be undone)");
