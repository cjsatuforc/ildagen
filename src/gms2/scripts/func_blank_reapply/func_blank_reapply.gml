if (j/checkpoints != ML_VM_GetVarReal(parser_cb,"point"))
{
    ML_VM_SetVarReal(parser_cb,"point",j/checkpoints);
	if (func_doaudio != 0)
	{
		ML_VM_SetVarReal(parser_cb, "audio_wave", buffer_peek(bufferIn, min(n,2047)*4, buffer_f32)/40000);
		ML_VM_SetVarReal(parser_cb, "audio_spectrum", buffer_peek(bufferOut, round(min(n/checkpoints*511,511))*4, buffer_f32));
	}
    ML_VM_SetVarReal(parser_cb,"x",ML_VM_GetVarReal(parser_cb,"startx")+xp);
    ML_VM_SetVarReal(parser_cb,"y",ML_VM_GetVarReal(parser_cb,"starty")+yp);
}
    
result_en = ML_Execute(parser_cb,compiled_en);
if (!ML_ResObj_HasAnswer(result_en))
{
    show_message_new("Unexpected value for BLANK at point="+string(j/checkpoints)+" , frame="+string(t));  
    ML_ResObj_Cleanup(result_en);
    ML_CompileCleanup(compiled_en);
    return 0;
}
    
answer_en = ML_ResObj_GetFinalAnswer(result_en);
ML_ResObj_Cleanup(result_en);
    
if (answer_en < 1) 
    blank = 1; 
else 
    blank = 0;
    
return 1;
