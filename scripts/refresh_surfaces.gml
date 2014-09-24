for (i = 0;i < ds_list_size(surf_list);i++)
    {
    surface_free(ds_list_find_value(surf_list,i))
    }
ds_list_clear(surf_list);

el_list = ds_list_find_value(frame_list,frame);
framepoints = 0;

draw_set_alpha(1);
for (i = 0;i < ds_list_size(el_list);i++)
    {
    new_list = ds_list_find_value(el_list,i);
    
    surf = surface_create(512,512);
    surface_set_target(surf);
        draw_clear_alpha(c_white,0);
        xo = ds_list_find_value(new_list,0)/128;
        yo = ds_list_find_value(new_list,1)/128;
        
        //TODO if just one
        
        for (u = 0; u < (((ds_list_size(new_list)-10)/6)-1); u++)
            {
            xp = ds_list_find_value(new_list,10+u*6+0);
            yp = ds_list_find_value(new_list,10+u*6+1);
            bl = ds_list_find_value(new_list,10+u*6+2);
            b = ds_list_find_value(new_list,10+u*6+3);
            g = ds_list_find_value(new_list,10+u*6+4);
            r = ds_list_find_value(new_list,10+u*6+5);
            
            nxp = ds_list_find_value(new_list,10+(u+1)*6+0);
            nyp = ds_list_find_value(new_list,10+(u+1)*6+1);
            nbl = ds_list_find_value(new_list,10+(u+1)*6+2);
            nb = ds_list_find_value(new_list,10+(u+1)*6+3);
            ng = ds_list_find_value(new_list,10+(u+1)*6+4);
            nr = ds_list_find_value(new_list,10+(u+1)*6+5);
            
            if (nbl == 0)
                {
                draw_set_color(make_colour_rgb(nr,ng,nb));
                if (xp == nxp) && (yp == nyp)
                    {
                    draw_rectangle(xo+xp/128-1,yo+yp/128-1,xo+xp/128+1,yo+yp/128+1,0);
                    }
                else
                    draw_line(xo+ xp/128,yo+ yp/128,xo+ nxp/128,yo+ nyp/128);
                }
            
            framepoints++;
            
            }
    surface_reset_target();
    ds_list_add(surf_list,surf);
    }

if (onion) and (frame)
    {
    el_list = ds_list_find_value(frame_list,frame-1);

    draw_set_alpha(0.6);
    for (i = 0;i < ds_list_size(el_list);i++)
        {
        new_list = ds_list_find_value(el_list,i);
        
        surf = surface_create(512,512);
        surface_set_target(surf);
            draw_clear_alpha(c_white,0);
            xo = ds_list_find_value(new_list,0)/128;
            yo = ds_list_find_value(new_list,1)/128;
            
            //TODO if just one
            
            for (u = 0; u < (((ds_list_size(new_list)-10)/6)-1); u++)
                {
                xp = ds_list_find_value(new_list,10+u*6+0);
                yp = ds_list_find_value(new_list,10+u*6+1);
                bl = ds_list_find_value(new_list,10+u*6+2);
                b = ds_list_find_value(new_list,10+u*6+3);
                g = ds_list_find_value(new_list,10+u*6+4);
                r = ds_list_find_value(new_list,10+u*6+5);
                
                nxp = ds_list_find_value(new_list,10+(u+1)*6+0);
                nyp = ds_list_find_value(new_list,10+(u+1)*6+1);
                nbl = ds_list_find_value(new_list,10+(u+1)*6+2);
                nb = ds_list_find_value(new_list,10+(u+1)*6+3);
                ng = ds_list_find_value(new_list,10+(u+1)*6+4);
                nr = ds_list_find_value(new_list,10+(u+1)*6+5);
                
                if (nbl == 0)
                    {
                    draw_set_color(make_colour_rgb(nr,ng,nb));
                    if (xp == nxp) && (yp == nyp)
                        {
                        draw_rectangle(xo+xp/128-1,yo+yp/128-1,xo+xp/128+1,yo+yp/128+1,0);
                        }
                    else
                        draw_line(xo+ xp/128,yo+ yp/128,xo+ nxp/128,yo+ nyp/128);
                    }
                
                }
        surface_reset_target();
        ds_list_add(surf_list,surf);
        }
    
    if (frame != 1)
        {
        el_list = ds_list_find_value(frame_list,frame-2);

        draw_set_alpha(0.4);
        for (i = 0;i < ds_list_size(el_list);i++)
            {
            new_list = ds_list_find_value(el_list,i);
            
            surf = surface_create(512,512);
            surface_set_target(surf);
                draw_clear_alpha(c_white,0);
                xo = ds_list_find_value(new_list,0)/128;
                yo = ds_list_find_value(new_list,1)/128;
                
                //TODO if just one
                
                for (u = 0; u < (((ds_list_size(new_list)-10)/6)-1); u++)
                    {
                    xp = ds_list_find_value(new_list,10+u*6+0);
                    yp = ds_list_find_value(new_list,10+u*6+1);
                    bl = ds_list_find_value(new_list,10+u*6+2);
                    b = ds_list_find_value(new_list,10+u*6+3);
                    g = ds_list_find_value(new_list,10+u*6+4);
                    r = ds_list_find_value(new_list,10+u*6+5);
                    
                    nxp = ds_list_find_value(new_list,10+(u+1)*6+0);
                    nyp = ds_list_find_value(new_list,10+(u+1)*6+1);
                    nbl = ds_list_find_value(new_list,10+(u+1)*6+2);
                    nb = ds_list_find_value(new_list,10+(u+1)*6+3);
                    ng = ds_list_find_value(new_list,10+(u+1)*6+4);
                    nr = ds_list_find_value(new_list,10+(u+1)*6+5);
                    
                    if (nbl == 0)
                        {
                        draw_set_color(make_colour_rgb(nr,ng,nb));
                        if (xp == nxp) && (yp == nyp)
                            {
                            draw_rectangle(xo+xp/128-1,yo+yp/128-1,xo+xp/128+1,yo+yp/128+1,0);
                            }
                        else
                            draw_line(xo+ xp/128,yo+ yp/128,xo+ nxp/128,yo+ nyp/128);
                        }
                    
                    }
            surface_reset_target();
            ds_list_add(surf_list,surf);
            }
        }
    }
    
el_list = ds_list_find_value(frame_list,frame);
draw_set_alpha(1);