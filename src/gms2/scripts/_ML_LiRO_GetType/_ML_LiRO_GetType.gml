/// @description _ML_LiRO_GetType(ind, n);
/// @function _ML_LiRO_GetType
/// @param ind
/// @param  n
/// @argType    r,r
/// @returnType string
/// @hidden     true
var list = _ML_LiRO_GetAllType(argument0);
return ds_list_find_value(list, argument1);
