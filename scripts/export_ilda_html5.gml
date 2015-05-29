//exports every element into an ilda file
placing_status = 0;

maxpoints = 0;

ilda_buffer = buffer_create(1,buffer_grow,1);

maxpointstot = 0;

maxframespost = maxframes;
maxframesa[0] = maxframespost & 255;
maxframespost = maxframespost >> 8;
maxframesa[1] = maxframespost & 255;

for (j = 0; j < maxframes;j++)
    {
    el_list = ds_list_find_value(frame_list,j);
    ds_list_sort(el_list,0);
    framepost = j;
    framea[0] = framepost & 255;
    framepost = framepost >> 8;
    framea[1] = framepost & 255;
    
    buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0005
    buffer_write(ilda_buffer,buffer_u8,$4C);
    buffer_write(ilda_buffer,buffer_u8,$44);
    buffer_write(ilda_buffer,buffer_u8,$41);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$0);
    buffer_write(ilda_buffer,buffer_u8,$5);
    buffer_write(ilda_buffer,buffer_u8,ord('L')); //name
    buffer_write(ilda_buffer,buffer_u8,ord('S'));
    buffer_write(ilda_buffer,buffer_u8,ord('G'));
    buffer_write(ilda_buffer,buffer_u8,ord('e'));
    buffer_write(ilda_buffer,buffer_u8,ord('n'));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    buffer_write(ilda_buffer,buffer_u8,ord('G')); //author
    buffer_write(ilda_buffer,buffer_u8,ord('i'));
    buffer_write(ilda_buffer,buffer_u8,ord('t'));
    buffer_write(ilda_buffer,buffer_u8,ord('l'));
    buffer_write(ilda_buffer,buffer_u8,ord('e'));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    buffer_write(ilda_buffer,buffer_u8,ord('M'));
    buffer_write(ilda_buffer,buffer_u8,ord(' '));
    maxpointspos = buffer_tell(ilda_buffer);
    buffer_write(ilda_buffer,buffer_u16,$300); //maxpoints
    buffer_write(ilda_buffer,buffer_u8,framea[1]); //frame
    buffer_write(ilda_buffer,buffer_u8,framea[0]); //frame
    buffer_write(ilda_buffer,buffer_u8,maxframesa[1]); //maxframes
    buffer_write(ilda_buffer,buffer_u8,maxframesa[0]); 
    buffer_write(ilda_buffer,buffer_u8,0); //scanner
    buffer_write(ilda_buffer,buffer_u8,0); //0
    
    optimize_middle3();
    
    if (!ds_list_size(el_list))
        {
        optimize_middle3();
        maxpointstot += maxpoints;
        maxpoints = 0;
        continue;
        }
    
    //optimize first
    if (exp_optimize == 1)
        {
        optimize_first();
        }
    
    for (i = 0;i < ds_list_size(el_list);i++)
        {
        list_id = ds_list_find_value(el_list,i);
        
        xo = ds_list_find_value(list_id,0);
        yo = ds_list_find_value(list_id,1);
        
        blanktemp = 0;
        
        //TODO if just one
        
        listsize = ((ds_list_size(list_id)-50)/6);
        
        var blankprev = 0;
        for (u = 0; u < listsize; u++)
            {
            //getting values from element list
                
            xp = xo+ds_list_find_value(list_id,50+u*6+0);
            yp = $ffff-(yo+ds_list_find_value(list_id,50+u*6+1));
            if ((yp > (512*128)) or (yp < 0) or (xp > (512*128)) or (xp < 0))
                {
                blanktemp = 1;
                continue;
                }
        
            b = ds_list_find_value(list_id,50+u*6+3);
            if (is_undefined(b) and bl) {b = 0}
            g = ds_list_find_value(list_id,50+u*6+4);
            if (is_undefined(g) and bl) {g = 0}
            r = ds_list_find_value(list_id,50+u*6+5);
            if (is_undefined(r) and bl) {r = 0}
            
            //adjusting values for writing to buffer
            xpe = xp;
            ype = yp;
            xp -= $8000;
            yp -= $8000;
            xpa[0] = xp & 255;
            xp = xp >> 8;
            xpa[1] = xp & 255;
            ypa[0] = yp & 255;
            yp = yp >> 8;
            ypa[1] = yp & 255;
            
            if (exp_optimize == 1) and (bl != blankprev)
                {
                repeat (3)
                    {
                    //writing point
                    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
                    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
                    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
                    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
                    buffer_write(ilda_buffer,buffer_u8,bl);
                    buffer_write(ilda_buffer,buffer_u8,b);
                    buffer_write(ilda_buffer,buffer_u8,g);
                    buffer_write(ilda_buffer,buffer_u8,r);
                    maxpoints++;
                    }
                blankprev = bl;
                }
            
            if (u = 0)
                blank = $40;
            else if (bl)
                {
                blank = $40;
                if (u == (ds_list_size(list_id)-50)/6-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $C0;
                }
            else
                {
                blank = $0;
                if (u == (ds_list_size(list_id)-50)/6-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $80;
                }
            if (blanktemp == 1)
                {
                blank = $40;
                blanktemp = 0;
                if (u == (ds_list_size(list_id)-50)/6-1) and (list_id = ds_list_find_value(el_list,ds_list_size(el_list)-1))
                    blank = $C0;
                }
            
            
            if !(((blank) and (blank != $80)) and (u != listsize-1) and (ds_list_find_value(list_id,50+(u+1)*6+2))) or (exp_optimize == 1)
                {
                //writing point
                buffer_write(ilda_buffer,buffer_u8,xpa[1]);
                buffer_write(ilda_buffer,buffer_u8,xpa[0]);
                buffer_write(ilda_buffer,buffer_u8,ypa[1]);
                buffer_write(ilda_buffer,buffer_u8,ypa[0]);
                buffer_write(ilda_buffer,buffer_u8,blank);
                buffer_write(ilda_buffer,buffer_u8,b);
                buffer_write(ilda_buffer,buffer_u8,g);
                buffer_write(ilda_buffer,buffer_u8,r);
                maxpoints++;
                }
            
            }
            
        //optimize between elements
        if (exp_optimize == 1) and (i != ds_list_size(el_list)-1)
            {
            optimize_between();
            }
        }
        
    //optimize last
    if (exp_optimize == 1)
        {
        optimize_last();
        }
        
    //update maxpoints
    maxpointspre = maxpoints;
    maxpointsa[0] = maxpoints & 255;
    maxpoints = maxpoints >> 8;
    maxpointsa[1] = maxpoints & 255;
    buffer_poke(ilda_buffer,maxpointspos,buffer_u8,maxpointsa[1]);
    buffer_poke(ilda_buffer,maxpointspos+1,buffer_u8,maxpointsa[0]);
    maxpointstot += maxpointspre;
    maxpoints = 0;
    }
    

//null header
buffer_write(ilda_buffer,buffer_u8,$49); //ILDA0005
buffer_write(ilda_buffer,buffer_u8,$4C);
buffer_write(ilda_buffer,buffer_u8,$44);
buffer_write(ilda_buffer,buffer_u8,$41);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$0);
buffer_write(ilda_buffer,buffer_u8,$5);
buffer_write(ilda_buffer,buffer_u8,ord('L')); //name
buffer_write(ilda_buffer,buffer_u8,ord('S'));
buffer_write(ilda_buffer,buffer_u8,ord('G'));
buffer_write(ilda_buffer,buffer_u8,ord('e'));
buffer_write(ilda_buffer,buffer_u8,ord('n'));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u8,ord('G')); //author
buffer_write(ilda_buffer,buffer_u8,ord('i'));
buffer_write(ilda_buffer,buffer_u8,ord('t'));
buffer_write(ilda_buffer,buffer_u8,ord('l'));
buffer_write(ilda_buffer,buffer_u8,ord('e'));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u8,ord('M'));
buffer_write(ilda_buffer,buffer_u8,ord(' '));
buffer_write(ilda_buffer,buffer_u16,0); //maxpoints
buffer_write(ilda_buffer,buffer_u16,0); //frame
buffer_write(ilda_buffer,buffer_u16,0); //maxframes
buffer_write(ilda_buffer,buffer_u8,0); //scanner
buffer_write(ilda_buffer,buffer_u8,0); //0

//export


ildastring = "";
buffersize = buffer_tell(ilda_buffer);

error = 0;
for (i = 0;i < buffersize;i++)
    {
    if (!toArray(i,buffer_peek(ilda_buffer,i,buffer_u8)))
        {
        if (!error) show_message_async("Error filling file with data, may not save correctly!");
        error = 1;
        }
    }
    
save(file_loc);
    
buffer_delete(ilda_buffer);
