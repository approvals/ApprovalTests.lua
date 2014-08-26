local function verify_files( received_file, approved_file )
	return 'Approved file does not exist: ' .. approved_file;
end

return {
	verify_files = verify_files
}