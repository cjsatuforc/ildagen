/// @description add_marker(position in frames)
/// @function add_marker
/// @param position in frames

if (ds_list_find_index(seqcontrol.marker_list,argument0) == -1)
    ds_list_add(seqcontrol.marker_list,argument0);
