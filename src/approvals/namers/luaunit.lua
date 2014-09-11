local function package_name( ... )
	local info = debug.getinfo(2)
	return info.source;
end 	

return {
	package_name = package_name
}