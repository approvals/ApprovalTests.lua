local   path   =   require(  'pl.path'  )

local   function verify_files(   actual_file,   expected_file   )
	local   message   =   nil

	if not path.exists(  expected_file  ) then
		message   =   	 'Approved expectation does not exist: ' .. expected_file;  
		return message
	end

	local   e_size   =   path.getsize(  expected_file  )
	local  a_size  =  path.getsize( actual_file )

	return string.format(  'File sizes do not match:\r\n%s(%d)\r\n%s(%d)',   expected_file,  e_size,  actual_file,  a_size  );  
end

return {  
	verify_files   =   verify_files
  }