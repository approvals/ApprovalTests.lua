local   path   =   require(  'pl.path'  )

local approval_missing = 'Approved expectation does not exist: %s'
local size_mismatch = 'File sizes do not match:\r\n%s(%d)\r\n%s(%d)'
local content_mismatch = 'File contents do not match:\r\n%s(%d)\r\n%s(%d)'

local   function verify_files(   actual_file,   expected_file   )
	local   message   =   nil

	if not path.exists(  expected_file  ) then
		return string.format(approval_missing, expected_file)
	end

	local e_size = path.getsize( expected_file )
	local a_size = path.getsize( actual_file )
	if  e_size ~= a_size then
		return string.format(size_mismatch, expected_file, e_size, actual_file, a_size);  
	end

	return string.format(content_mismatch, expected_file, e_size, actual_file, a_size);  
end

return {  
	verify_files   =   verify_files
  }