//all the interaction with the timeline

if (mouse_x == clamp(mouse_x,0,tlw)) 
&& (mouse_y == clamp(mouse_y,132,room_height))
    {
    if (mouse_wheel_up())
        {
        tlzoom *= 0.8;
        if (tlzoom < 10) tlzoom = 10;
        }
    if (mouse_wheel_down())
        tlzoom *= 1.2;
    }
    
mouseonsomelayer = 0;
scrollbarw = clamp(((tlzoom+18)/length)*tlw-18,32,tlw-18);
if (length != tlzoom)
    scrollbarx = (tlw-18-scrollbarw)*(tlx)/(length-tlzoom);
layerbarw = clamp(lbh/(ds_list_size(layer_list)*48+lbh)*(lbh-1),32,lbh-1);

if (moving_object == 1)
    {
    draw_mouseline = 1;
    //currently dragging object on timeline
    ds_list_replace(layertomove,objectindex,max(0,ds_list_find_value(layertomove,objectindex)+(mouse_x-mousexprev)*tlzoom/tlw));
    mousexprev = mouse_x;
    
    if (mouse_y > (mouseyprev+48)) and (ds_list_find_index(layer_list,layertomove) < (ds_list_size(layer_list)-1))
        {
        //move to lower layer
        mouseyprev = mouse_y;
        var newlayertomove = ds_list_find_value(layer_list,ds_list_find_index(layer_list,layertomove)+1);
        ds_list_add(newlayertomove,ds_list_find_value(layertomove,objectindex));
        ds_list_add(newlayertomove,ds_list_find_value(layertomove,objectindex+1));
        ds_list_add(newlayertomove,ds_list_find_value(layertomove,objectindex+2));
        repeat (3) ds_list_delete(layertomove,objectindex);
        layertomove = newlayertomove;
        objectindex = ds_list_size(newlayertomove)-3;
        selectedlayer = ds_list_find_index(layer_list,newlayertomove);
        selectedx = -objectindex;
        }
    else if (mouse_y < (mouseyprev-48)) and (ds_list_find_index(layer_list,layertomove) > 0)
        {
        //move to above layer
        mouseyprev = mouse_y;
        var newlayertomove = ds_list_find_value(layer_list,ds_list_find_index(layer_list,layertomove)-1);
        ds_list_add(newlayertomove,ds_list_find_value(layertomove,objectindex));
        ds_list_add(newlayertomove,ds_list_find_value(layertomove,objectindex+1));
        ds_list_add(newlayertomove,ds_list_find_value(layertomove,objectindex+2));
        repeat (3) ds_list_delete(layertomove,objectindex);
        layertomove = newlayertomove;
        objectindex = ds_list_size(newlayertomove)-3;
        selectedlayer = ds_list_find_index(layer_list,newlayertomove);
        selectedx = -objectindex;
        }
    if (mouse_check_button_released(mb_left))
        {
        var tempxstart = round(ds_list_find_value(layertomove,objectindex));
        if (!keyboard_check(vk_alt))
            {
            //check for collisions with other objects. tempx* is pos. of object being moved, tempx*2 is pos of other objects in layer
            var loop = 1;
            while (loop)
                {
                loop = 0;
                var tempxend = tempxstart + ds_list_find_value(ds_list_find_value(layertomove,objectindex+2),0);
                for ( u = 0; u < ds_list_size(layertomove); u+= 3)
                    {
                    if (u == objectindex) continue;
                    var tempxstart2 = ds_list_find_value(layertomove,u); 
                    if (tempxstart2 > tempxend) //if end collides with start ahead
                        continue;
    
                    var tempxend2 = tempxstart2 + ds_list_find_value(ds_list_find_value(layertomove,u+2),0);
                    if (tempxend2 < tempxstart) //if start collides with end behind
                        continue;
                        
                    loop = 1;
                    if (tempxstart2 < tempxstart)
                        {
                        tempxstart = tempxend2+1;
                        }
                    else
                        {
                        tempxstart = tempxstart2-1-(tempxend-tempxstart);
                        }
                    }
                }
            }
            
        ds_list_add(undolisttemp,layertomove);
        ds_list_add(undo_list,"m"+string(undotemplist));
        
        ds_list_replace(layertomove,objectindex,tempxstart);
        moving_object = 0;
        }
    exit;
    }
else if (moving_object == 2)
    {
    draw_mouseline = 1;
    //resizing object on timeline
    ds_list_replace(infolisttomove,0,max(1,ds_list_find_value(infolisttomove,0)+(mouse_x-mousexprev)*tlzoom/tlw));
    mousexprev = mouse_x;
    if (mouse_check_button_released(mb_left))
        {
        ds_list_replace(infolisttomove,0,round(ds_list_find_value(infolisttomove,0)));
        
        ds_list_add(undo_list,"r"+string(undotemplist));
        
        moving_object = 0;
        }
    exit;
    }
else if (moving_object == 3)
    {
    //moving startframe
    startframe += (mouse_x-mousexprev)*tlzoom/tlw;
    if (startframe < 0) startframe = 0;
    mousexprev = mouse_x;
    if (mouse_check_button_released(mb_left))
        {
        startframe = round(startframe);
        moving_object = 0;
        }
    exit;
    }
else if (moving_object == 4)
    {
    //moving endframe
    endframe += (mouse_x-mousexprev)*tlzoom/tlw;
    mousexprev = mouse_x;
    if (mouse_check_button_released(mb_left))
        {
        endframe = round(endframe);
        moving_object = 0;
        }
    exit;
    }
    
    
//horizontal
if (mouse_x == clamp(mouse_x,scrollbarx,scrollbarx+scrollbarw)) 
&& (mouse_y == clamp(mouse_y,room_height-16,room_height))
    {
    mouseonsomelayer = 1;
    controller.tooltip = "Drag to scroll the timeline. Hold and scroll the mouse wheel to zoom";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
        {
        scroll_moving = 1;
        mousexprev = mouse_x;
        }
    }
//vertical
else if (mouse_y == clamp(mouse_y,tls+layerbarx,tls+layerbarx+layerbarw)) 
&& (mouse_x == clamp(mouse_x,tlw-16,tlw))
    {
    mouseonsomelayer = 1;
    controller.tooltip = "Drag to scroll the layer list.";
    if (scroll_moving == 0) && mouse_check_button_pressed(mb_left)
        {
        scroll_moving = 2;
        mouseyprev = mouse_y;
        }
    }
    
//horizontal
if (scroll_moving == 1)
    {
    tlx += (mouse_x-mousexprev)*(length/(tlw-17));
    if (tlx < 0) tlx = 0;
    if ((tlx+tlzoom) > length) length = tlx+tlzoom;
    
    mousexprev = mouse_x;
    
    if (mouse_check_button_released(mb_left))
        scroll_moving = 0;
    }
//vertical
else if (scroll_moving == 2)
    {
    layerbarx += (mouse_y-mouseyprev)*lbh/layerbarw;//*(length/tlw);
    if (layerbarx < 0) layerbarx = 0;
    if ((layerbarx/48) > ds_list_size(layer_list)) layerbarx = (ds_list_size(layer_list))*48;
    
    mouseyprev = mouse_y;
    
    if (mouse_check_button_released(mb_left))
        scroll_moving = 0;
    }
    
if !((mouse_x == clamp(mouse_x,0,tlw)) 
&& (mouse_y == clamp(mouse_y,132,room_height)))
    exit;
//startframe
if (mouse_x == clamp(mouse_x,startframex-2,startframex+2))                         
    {
    controller.tooltip = "Drag to adjust the start of the project";
    if (mouse_check_button_pressed(mb_left))
        {
        mousexprev = mouse_x;
        moving_object = 3;
        //show_debug_message("yes")
        }
    exit;
    }
//endframe
else if (mouse_x == clamp(mouse_x,endframex-2,endframex+2))                         
    {
    controller.tooltip = "Drag to adjust the end of the project";
    if (mouse_check_button_pressed(mb_left))
        {
        mousexprev = mouse_x;
        moving_object = 4;
        }
    exit;
    }

//layers
draw_cursorline = 0;
tempstartx = tls-layerbarx;


for (i = 0; i <= ds_list_size(layer_list);i++)//( i = floor(layerbarx/48); i < floor((layerbarx+lbh)/48); i++)
    {
    if (i < floor(layerbarx/48))
        continue;
        
    mouseonlayer = (mouse_x == clamp(mouse_x,0,tlw-16)) && (mouse_y == clamp(mouse_y,tempstartx+i*48,tempstartx+i*48+48))
    if (mouseonlayer)
        {
        mouseover = (mouse_x == clamp(mouse_x,8,40)) && (mouse_y == clamp(mouse_y,tempstartx+i*48+8,tempstartx+i*48+40))
        if (i == ds_list_size(layer_list))
            {
            if (mouseover) 
                {
                mouseonsomelayer = 1;
                controller.tooltip = "Click to create a new layer";
                if  mouse_check_button_pressed(mb_left)
                    {
                    newlayer = ds_list_create();
                    ds_list_add(layer_list,newlayer);
                    }
                }
            else
                draw_mouseline = 1;
            break;
            }
            
        mouseonsomelayer = 1;
        if (mouseover) 
            {
            controller.tooltip = "Click to delete this layer and all its content";
            if  mouse_check_button_pressed(mb_left)
                {
                layertodelete = ds_list_find_value(layer_list,i);
                seq_dialog_yesno("layerdelete","Are you sure you want to delete this layer? (Cannot be undone)");
                }
            }
        else
            {
            //mouse on layer but not button
            layer = ds_list_find_value(layer_list, i);
            for (m = 0; m < ds_list_size(layer); m += 3)
                {
                infolist =  ds_list_find_value(layer,m+2);
                frametime = ds_list_find_value(layer,m);
                object_length = ds_list_find_value(infolist,0);
                correctframe = round(tlx+mouse_x/tlw*tlzoom);
                draw_mouseline = 1;
                
                if (correctframe == clamp(correctframe, frametime-2, frametime+object_length+1))
                    {
                    //mouse over object
                    controller.tooltip = "Click and drag to move object. Drag the far edge to adjust duration.#Double-click to edit frames#Right click for more actions";
                    if  mouse_check_button_pressed(mb_left)
                        {
                        selectedlayer = i;
                        selectedx = -m;
                        if (doubleclick)
                            {
                            //edit object
                            seq_dialog_yesno("fromseq","This will discard unsaved changes in the frames editor. Continue? (Cannot be undone)");
                            }
                        else
                            {
                            if (mouse_x > ((frametime-tlx)/tlzoom*tlw)+object_length/tlzoom*tlw-2)
                                {
                                //resize object
                                moving_object = 2;
                                infolisttomove = infolist;
                               
                                undotemplist = ds_list_create();
                                ds_list_add(undolisttemp,infolisttomove);
                                ds_list_add(undolisttemp,ds_list_find_value(infolisttomove,0));
                                
                                mousexprev = mouse_x;
                                }
                            else
                                {
                                //drag object
                                moving_object = 1;
                                objectindex = m;
                                layertomove = layer;
                                infolisttomove = infolist;
                                
                                undotemplist = ds_list_create();
                                ds_list_add(undolisttemp,layertomove);
                                ds_list_add(undolisttemp,infolisttomove);
                                ds_list_add(undolisttemp,ds_list_find_value(layertomove,objectindex));
                                
                                mousexprev = mouse_x;
                                mouseyprev = mouse_y;
                                }
                            }
                        }
                    else if mouse_check_button_pressed(mb_right)
                        {
                        //right clicked on object
                        selectedlayer = i;
                        selectedx = -m;
                        dropdown_seqobject();
                        }
                    exit;
                    }
                }
                
            controller.tooltip = "Click to select this layer position#Right click for more options";
            floatingcursorx = round(tlx+mouse_x/tlw*tlzoom);
            floatingcursory = tempstartx+i*48-1;
            draw_cursorline = 1;
            draw_mouseline = 1;
            
            if  mouse_check_button_pressed(mb_left)
                {
                selectedlayer = i;
                selectedx = floatingcursorx;
                }
            else if  mouse_check_button_pressed(mb_right)
                {
                selectedlayer = i;
                selectedx = floatingcursorx;
                dropdown_layer();
                }
                
            }
        }
    }
    
if !(mouseonsomelayer)
    {
    draw_mouseline = 1;
    if (mouse_y > 132)
        {
        //mouse over layer area
        controller.tooltip = "Click to set playback position.";
        if  mouse_check_button_pressed(mb_left)
            {
            tlpos = (tlx+mouse_x/tlw*tlzoom)/projectfps*1000;
            if (song)
                FMODInstanceSetPosition(songinstance,(tlpos-10)/FMODSoundGetLength(song));
            }
        }
    }
    
    
    