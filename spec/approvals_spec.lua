local approvals = require [[approvals]]
describe('approvals',function()
	it('passes when actual matches expected', function()
		approvals.verify('the actual result')
	end)
end)