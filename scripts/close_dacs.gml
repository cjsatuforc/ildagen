//cleanup
for (i = ds_list_size(dac_list)-1; i >= 0; i--)
{
    var daclist = dac_list[| i];
    dac_blank_and_center(daclist);
}
