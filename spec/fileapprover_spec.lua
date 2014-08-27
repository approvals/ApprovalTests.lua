local  fileapprover  =  require 'approvals.fileapprover'
local utilities = require 'approvals.utilities'

local function create_text_file( name, contents )
		local actual = utilities.adjacent_path(name)
		local a = assert(io.open(actual, 'w'))
		a:write(contents)
		a:close()
		return actual
end

describe( 'A file approver',  function(  )
	it( 'fails on missing expected file',  function (    )
		local  actual  =  fileapprover.verify_files( nil,  'foo.txt' )
		assert.equal( 'Approved expectation does not exist: foo.txt',  actual )

	end ) 

	it( 'fails when file sizes differ',  function (    )
		
		local actual = create_text_file('a.txt', 'hello')
		local expected = create_text_file('e.txt', 'hello world')

		local  message  =  fileapprover.verify_files( actual,  expected )
		assert.equal( 'File sizes do not match:\r\n.\\spec\\e.txt(11)\r\n.\\spec\\a.txt(5)',  message )
	end )

	it('fails when file contents differ', function (  )
		local actual = create_text_file('ac.txt','12345')
		local expected = create_text_file('ec.txt','54321')

		local message = fileapprover.verify_files( actual, expected )
		assert.equal( 'File contents do not match:\r\n.\\spec\\ec.txt(5)\r\n.\\spec\\ac.txt(5)', message);
	end)


	it('passes when files are same', function (  )
		local actual = create_text_file('as.txt','12345')
		local expected = create_text_file('es.txt','12345')

		local message = fileapprover.verify_files( actual, expected )
		assert.falsy(message);
	end)

end )