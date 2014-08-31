local path = require( 'pl.path' )

local approval_missing = 'Approved expectation does not exist: %s'
local size_mismatch = 'File sizes do not match:\r\n%s(%d)\r\n%s(%d)'
local content_mismatch = 'File contents do not match:\r\n%s(%d)\r\n%s(%d)'

local function read_all_binary( path )
  local a = assert(io.open(path,  "rb"))
  local actual = a:read("*all")
  return actual
end

local function contents_same( actual_file, expected_file )

  local actual = read_all_binary(actual_file)
  local expect = read_all_binary(expected_file)

  local an = #actual
  if an ~= #expect then
    return false
  end

  for i=1,an do
    if actual:sub(i,i) ~= expect:sub(i,i) then
      return false
    end
  end

  return true
end

local function verify_files(actual_file, expected_file)
  local message = nil

  if not path.exists(expected_file) then
    return string.format(approval_missing, expected_file)
  end

  local e_size = path.getsize( expected_file )
  local a_size = path.getsize( actual_file )
  if  e_size ~= a_size then
    e_size = e_size or 0
    a_size = a_size or 0
    return string.format(size_mismatch, expected_file, e_size, actual_file, a_size);
  end

  if not contents_same(actual_file, expected_file) then
    return string.format(content_mismatch, expected_file, e_size, actual_file, a_size);
  end

  return nil
end

local function verify( writer, namer, reporter )
  local actual_file = namer.actual_file(writer.extension)
  writer.write(actual_file)
  local expected_file = namer.expected_file(writer.extension)

  local message = verify_files(actual_file, expected_file)

  local ok = not message
  if not ok then
    reporter:report( actual_file, expected_file)
    print (message)
  else
    os.remove(actual_file)
  end

  return ok
end



return {
  verify = verify,
  verify_files = verify_files
}
