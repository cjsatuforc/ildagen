//creates an element from whatever has been done on the screen

placing_status = 0;

new_list = ds_list_create();

ds_list_add(new_list,startpos[0]*128); //origo x
ds_list_add(new_list,startpos[1]*128); //origo y
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);
ds_list_add(new_list,0);

if (placing == "line")
    {
    checkpoints = ceil(point_distance(startpos[0],startpos[1],mouse_x,512-mouse_y,)*128/resolution);
    if (checkpoints < 2) checkpoints = 2;
    vector[0] = (mouse_x-startpos[0])/checkpoints;
    vector[1] = (512-mouse_y-startpos[1])/checkpoints;
    
    for (n = 0;n <= checkpoints; n++)
        {
        if (colormode = "solid")
            {
            c[0] = colour_get_blue(color1);
            c[1] = colour_get_green(color1);
            c[2] = colour_get_red(color1);
            }
            
        blank = 0;
        
        ds_list_add(new_list,n*vector[0]*128);
        ds_list_add(new_list,n*vector[1]*128);
        ds_list_add(new_list,blank);
        ds_list_add(new_list,c[0]);
        ds_list_add(new_list,c[1]);
        ds_list_add(new_list,c[2]);
        
        }
    }
    
ds_list_add(el_list,new_list);
