local path = require 'pl.path'

local function caller_directory(  )
	local source = debug.getinfo(2).source
	return path.dirname(source)
end

return {
	caller_directory = caller_directory
}