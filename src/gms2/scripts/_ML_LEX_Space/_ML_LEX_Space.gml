/// @description _ML_LEX_Space(char)
/// @function _ML_LEX_Space
/// @param char
/// @argType    s
/// @returnType r
/// @hidden     true
var v = ord(argument0);
return v == 32 || (v >= 9 && v <= 13);
