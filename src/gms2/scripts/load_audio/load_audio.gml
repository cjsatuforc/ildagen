var t_songfile_loc = get_open_filename_ext("","","","Select audio file");
if !string_length(t_songfile_loc) 
{
    log("cancel");
    exit;
}
remove_audio();
song_buffer = buffer_load(t_songfile_loc);
var t_exInfo = buffer_create(34*8, buffer_fixed, 8);
buffer_fill(t_exInfo, 0, buffer_u64, 0, buffer_get_size(t_exInfo));
buffer_poke(t_exInfo, 0, buffer_u32, buffer_get_size(song_buffer));
song = FMODGMS_Snd_LoadSound_Ext(buffer_get_address(song_buffer),	FMODGMS_MODE_DEFAULT | 
																	FMODGMS_MODE_OPENMEMORY_POINT | 
																	FMODGMS_MODE_ACCURATETIME |
																	FMODGMS_MODE_CREATECOMPRESSEDSAMPLE, 
																	buffer_get_address(t_exInfo));
song_parse = FMODGMS_Snd_LoadSound_Ext(buffer_get_address(song_buffer),	FMODGMS_MODE_DEFAULT | 
																		FMODGMS_MODE_ACCURATETIME |
																		FMODGMS_MODE_OPENMEMORY_POINT | 
																		FMODGMS_MODE_CREATESTREAM |
																		FMODGMS_MODE_OPENONLY, 
																		buffer_get_address(t_exInfo));
														
buffer_delete(t_exInfo);

if (song == -1 || song_parse == -1)
{
    show_message_new("Failed to load audio: "+FMODGMS_Util_GetErrorMessage());
    exit;
}

song_samplerate = FMODGMS_Snd_Get_DefaultFrequency(song);

songfile_name = FMODGMS_Snd_Get_TagStringFromName(song, "TIT2");
if (songfile_name == "Tag not found.")
{
	songfile_name = FMODGMS_Snd_Get_TagStringFromName(song, "TITLE");
	if (songfile_name == "Tag not found.")
		songfile_name = filename_name(t_songfile_loc);
}

/*if (!song and (FMODGetLastError() == 25))
{
    temprandomstring = string(irandom(1000000));
    buffer_save(song_buffer,"temp/tempaudio"+temprandomstring+filename_ext(songfile));
    song = FMODGMS_Snd_LoadStream(controller.FStemp+"tempaudio"+temprandomstring+filename_ext(songfile));
}*/

ds_list_clear(audio_list);
//FMODGMS_Snd_PlaySound(song, parse_sndchannel);
//FMODGMS_Chan_ResumeChannel(parse_sndchannel);
//fmod_set_pos(parse_sndchannel, 0);
FMODGMS_Snd_PlaySound(song, play_sndchannel);
songlength = fmod_get_length(song);
if (length < songlength/1000*projectfps)
{
    length = ceil(songlength/1000*projectfps);
    endframe = length;
}
parsingaudio = true;
parsingaudio_pos = 0;
deltatime = 0;    
playing = 0;
tlpos = 0;

apply_audio_settings();