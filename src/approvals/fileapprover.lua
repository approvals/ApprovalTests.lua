local path = require( 'pl.path' )

local approval_missing = 'Approved expectation does not exist: %s'
local size_mismatch = 'File sizes do not match:\r\n%s(%d)\r\n%s(%d)'
local content_mismatch = 'File contents do not match:\r\n%s(%d)\r\n%s(%d)'

local function contents_same( actual_file, expected_file )
  local a = assert(io.open(actual_file,  "rb"))
  local e = assert(io.open(expected_file,"rb"))

  local actual = a:read("*all")
  local expect = e:read("*all")

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

local function verify( writer, namer, reporter )
  reporter:report( namer.actual_file('.txt'), namer.expected_file('.txt'))
  return nil
end
  

local function verify_files(actual_file, expected_file)
  local message = nil

  if not path.exists(expected_file) then
    return string.format(approval_missing, expected_file)
  end

  local e_size = path.getsize( expected_file )
  local a_size = path.getsize( actual_file )
  if  e_size ~= a_size then
    return string.format(size_mismatch, expected_file, e_size, actual_file, a_size);
  end

  if not contents_same(actual_file, expected_file) then
    return string.format(content_mismatch, expected_file, e_size, actual_file, a_size);
  end

  return nil
end

return {
  verify = verify,
  verify_files   =   verify_files
}
