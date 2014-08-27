local  fileapprover  =  require 'approvals.fileapprover'
local utilities = require 'approvals.utilities'

describe( 'A file approver',  function(  )
	it( 'fails on missing expected file',  function (    )
		local  actual  =  fileapprover.verify_files( nil,  'foo.txt' )
		assert.equal( 'Approved expectation does not exist: foo.txt',  actual )

	end ) 

	it( 'fails when file sizes differ',  function (    )
		local actual = utilities.adjacent_path('a.txt')
		local a = assert(io.open(actual, 'w'))
		a:write('hello')
		a:close()
		local expected = 	utilities.adjacent_path('e.txt')
		local e = assert(io.open(expected, 'w'))
		e:write('hello world')
		e:close()
		local  actual  =  fileapprover.verify_files( actual,  expected )
		assert.equal( 'File sizes do not match:\r\n.\\spec\\e.txt(11)\r\n.\\spec\\a.txt(5)',  actual )
	end )
end )