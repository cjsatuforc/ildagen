if (instance_exists(obj_dropdown))
    exit;
	
if (!verify_serial(1))
	exit;
seq_dialog_yesno("loadproject","This will replace your current project, all unsaved work will be lost. Continue? (Cannot be undone)");

