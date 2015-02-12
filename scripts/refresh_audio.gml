var numentries = 1024;
    
FMODUpdate();

if (errorcheck == 0) and (deltatime > 1000/60*10)
    {
    errorcheck = 1;
    }
deltatimeprev = (ds_list_size(audio_list)-1)/3//deltatime;
deltatime = FMODInstanceGetPosition(parseinstance)*FMODSoundGetLength(song);//+= delta_time;

repeatc = (floor(deltatime/1000*60 - ds_list_size(audio_list)/3))//deltatimeprev/1000000*60-1)
if (errorcheck) && (repeatc)
    {
    lastw = ds_list_find_value(audio_list,ds_list_size(audio_list)-3);
    lastr = ds_list_find_value(audio_list,ds_list_size(audio_list)-2);
    lastb = ds_list_find_value(audio_list,ds_list_size(audio_list)-1);
    repeat (repeatc)
        {
        ds_list_add(audio_list,lastw);
        ds_list_add(audio_list,lastr);
        ds_list_add(audio_list,lastb);
        }
    }
//show_debug_message(ds_list_size(audio_list))
//show_debug_message(errorcheck)
    
    

FMODInstanceGetWaveSnapshot2(parseinstance,0,numentries);
w = FMODNormalizeWaveData(0,numentries);
ds_list_add(audio_list,ln(1+clamp(w*1.5,0,3.4)));
FMODSpectrumSetSnapshotType(1);
FMODInstanceGetSpectrumSnapshot2(parseinstance,0,numentries);
s = FMODNormalizeSpectrumData(0,5);
ds_list_add(audio_list,ln(1+clamp(s*8,0,3.4)));
s = FMODNormalizeSpectrumData(40,150);
ds_list_add(audio_list,ln(1+clamp(s*8,0,3.4)));

pos = FMODInstanceGetPosition(parseinstance);

//if (pos/1000*projectfps == clamp(pos/1000*projectfps,tlx,tlx+tlzoom))
   // refresh_audio_surf();
    
if (pos >= 0.999)
    {
    parsingaudio = 0;
    deltatime = 0;
    FMODInstanceStop(parseinstance);
    }