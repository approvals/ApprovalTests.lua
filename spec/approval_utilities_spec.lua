local ut = require 'approvals.utilities'

describe('Path utilities', function (  )
	it('gets the script directory', function (  )
		local actual = ut.caller_directory()
		local expected = [[@.\spec]]
		assert.equal(expected,actual)
	end)
end)