///dac_blank_and_center(dac list)

log("blanking");

active_dac = argument0;

if (active_dac[| 1] == 0) //riya
{
    buffer_seek(controller.blank_frame, buffer_seek_start, 0);
    buffer_write(controller.blank_frame, buffer_u16, $800);
    buffer_write(controller.blank_frame, buffer_u16, $800);
    buffer_write(controller.blank_frame, buffer_u32, 0);
    
    log(dac_riya_outputframe(active_dac[| 0], 10000, 1, buffer_get_address(controller.blank_frame)));
}
else if (active_dac[| 1] == 1) //lasdac
{
    buffer_seek(controller.blank_frame, buffer_seek_start, 0);
    buffer_write(controller.blank_frame, buffer_u16, $800);
    buffer_write(controller.blank_frame, buffer_u16, $800);
    buffer_write(controller.blank_frame, buffer_u32, 0);
    
    dac_lasdac_outputframe(active_dac[| 0], 10000, 1, buffer_get_address(controller.blank_frame));
}