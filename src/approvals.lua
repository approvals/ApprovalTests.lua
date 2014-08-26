local textwriter = require 'approvals.textwriter'

local function verify( actual )
	local writer = textwriter.new(actual)
	return fileapprover.verify( writer, namer, reporter )

	-- -- local result = actual

	-- -- assert(result==nil, result)

	-- return true
end

return {
	verify = verify
}