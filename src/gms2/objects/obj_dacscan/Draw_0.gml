draw_self();

if (controller.dac == -1)
{   
    draw_set_valign(fa_middle);
    draw_set_colour(c_maroon);
    draw_text(x+55, y+16, "[No default DAC selected]");
    draw_set_valign(fa_top);
    draw_set_colour(c_black);
    gpu_set_blendenable(true);
}


