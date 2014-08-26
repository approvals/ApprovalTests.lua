local  fileapprover  =  require 'approvals.fileapprover'

describe( 'A file approver',  function(  )
	it( 'fails on missing expected file',  function (    )
		local  actual  =  fileapprover.verify_files( nil,  'foo.txt' )
		assert.equal( 'Approved file does not exist: foo.txt',  actual )

	end ) 

	it( 'fails when file sizes differ',  function (    )
		local  actual  =  fileapprover.verify_files( 'r.txt',  'a.txt' )
		assert.equal( 'File sizes do not match: \r\na.txt(5)\r\\nb.txt(3)',  actual )
	end )
end )