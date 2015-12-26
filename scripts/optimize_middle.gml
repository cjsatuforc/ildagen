if (controller.exp_optimize == 0)
    maxpointswanted = 1;
else
    maxpointswanted = floor((1/controller.projectfps)*controller.opt_scanspeed); 

xp = $8000;
yp = $8000;

xp -= $8000;
yp -= $8000;
xpa[0] = xp & 255;
xp = xp >> 8;
xpa[1] = xp & 255;
ypa[0] = yp & 255;
yp = yp >> 8;
ypa[1] = yp & 255;

for (m = 0; m < maxpointswanted-1; m++)
    {
    //writing point
    buffer_write(ilda_buffer,buffer_u8,xpa[1]);
    buffer_write(ilda_buffer,buffer_u8,xpa[0]);
    buffer_write(ilda_buffer,buffer_u8,ypa[1]);
    buffer_write(ilda_buffer,buffer_u8,ypa[0]);
    
    if (controller.exp_format == 5)
        {
        buffer_write(ilda_buffer,buffer_u8,$40);
        buffer_write(ilda_buffer,buffer_u8,0);
        buffer_write(ilda_buffer,buffer_u8,0);
        buffer_write(ilda_buffer,buffer_u8,0);
        }
    else
        {
        buffer_write(ilda_buffer,buffer_u16,0);
        buffer_write(ilda_buffer,buffer_u8,$40);
        buffer_write(ilda_buffer,buffer_u8,0);
        }
    }
buffer_write(ilda_buffer,buffer_u8,xpa[1]);
buffer_write(ilda_buffer,buffer_u8,xpa[0]);
buffer_write(ilda_buffer,buffer_u8,ypa[1]);
buffer_write(ilda_buffer,buffer_u8,ypa[0]);

if (controller.exp_format == 5)
    {
    buffer_write(ilda_buffer,buffer_u8,$C0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    buffer_write(ilda_buffer,buffer_u8,0);
    }
else
    {
    buffer_write(ilda_buffer,buffer_u16,0);
    buffer_write(ilda_buffer,buffer_u8,$C0);
    buffer_write(ilda_buffer,buffer_u8,0);
    }