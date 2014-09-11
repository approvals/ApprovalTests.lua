package.path = package.path .. ";./src/?.lua"
local namer = require [[approvals.namers.luaunit]]
local LuaUnit = require 'luaunit'

TestLuaUnitNamer = {} 

function TestLuaUnitNamer:test_knows_package_name()
    assertEquals( namer.package_name(), 'TestLuaUnitNamer' )
end

function TestLuaUnitNamer:test_knows_method_name()
    assertEquals( namer.method_name(), 'test_knows_method_name' )
end

LuaUnit:run()