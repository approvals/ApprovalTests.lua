
package = "ApprovalTests"
version = "0.0.1-1"
source = {
  url = "..." -- We don't have one yet
}
description = {
  summary = "ApprovalTests for Lua.",
  detailed = [[
      Capturing Human Intelligence - ApprovalTests 
      is an open source assertion/verification library 
      to aid testing.  This is the ApprovalTests port 
      for Lua.
   ]],
  homepage = "http://...", -- We don't have one yet
  license = "apache2" -- or whatever you like
}
dependencies = {
  "lua ~> 5.1"
-- If you depend on other rocks, add them here
}
build = {
  type = "builtin",
  modules = {
    approvals = "src/approvals.lua"
  }
-- We'll start here.
}
