with (obj_colorscale)
    {
    activecolor = make_colour_rgb(  controller.red_scale*255,
                                    controller.green_scale*255,
                                    controller.blue_scale*255);
    redy = y+23-(colour_get_red(activecolor)/255*23);
    greeny = y+23-(colour_get_green(activecolor)/255*23);
    bluey = y+23-(colour_get_blue(activecolor)/255*23);
    }
