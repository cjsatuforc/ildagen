if (view_current != 0)
    exit;

draw_self();
draw_sprite(spr_aniknob,(moving > 0),x+clamp(controller.aniwave_amp,-$ffff/2,$ffff/2)/$ffff*2*64,y+16);

draw_text(x+87,y+9,"Amplitude: "+string(round(controller.aniwave_amp)));

