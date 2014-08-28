local path = require 'pl.path'

local function caller_directory( level )
  local n = level or 1
  local source = debug.getinfo(n + 1).source
  return path.dirname(source):sub(2)
end

local function adjacent_path( name )
  return path.join( caller_directory(2), name )
end

return {
  caller_directory = caller_directory,
  adjacent_path = adjacent_path
}
