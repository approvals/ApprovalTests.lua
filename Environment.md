I'm currently using busted as my test framework of choice, so the specs for approvals are written in busted.

While I like busted, its a pain in the behind to install.  Here are some problems and solutions I encountered along the way.

# Problem

    luarocks install busted --local
    Installing http://luarocks.org/repositories/rocks/busted-2.0.rc3-0.src.rock...
    
    Error: Parse error processing dependency 'lua_cliargs >= 2.0'
    
# Solution

Update Lua Rocks

Download from luarocks.org

# Problem

`C:\Program Files (x86)\LuaRocks\2.2 exists. Use /F to force removal and reinstallation.`

# Solution

Put the path to luarocks before the path to lua

Protip: use `RefreshEnv` from choco to avoid opening a new shell

# Problem
    
    Using https://rocks.moonscript.org/luafilesystem-1.6.2-2.src.rock... switching to 'build' mode
    cl /MD /O2 -c -Fosrc/lfs.obj -IC:/Program Files (x86)/Lua/5.1/include/ src/lfs.c
    'cl' is not recognized as an internal or external command,
    operable program or batch file.
    
    Error: Failed installing dependency: https://rocks.moonscript.org/penlight-1.3.1-1.src.rock - Failed installing dependency: https://rocks.moonscript.org/luafilesystem-1.6.2-2.src.rock - Build error: Failed compiling object src/lfs.obj

# Solution

run the appropriate vsvars thingy.

`"C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"`

Protip: configure console 2 to run this on start-up

# Problem

Slightly different this time

    Microsoft (R) C/C++ Optimizing Compiler Version 17.00.61030 for x86
    Copyright (C) Microsoft Corporation.  All rights reserved.
    
    lfs.c
    c:\users\jcounts\appdata\local\temp\luarocks_luafilesystem-1.6.2-2-6201\luafilesystem-1.6.2\src\lfs.c(413) : warning C4716: 'make_link' : must return a value
    link -dll -def:lfs.def -out:lfs.dll C:/Program Files (x86)/Lua/5.1/lua5.1.dll src/lfs.obj
    Microsoft (R) Incremental Linker Version 11.00.61030.0
    Copyright (C) Microsoft Corporation.  All rights reserved.
    
    C:\Program Files (x86)\Lua\5.1\lua5.1.dll : fatal error LNK1107: invalid or corrupt file: cannot read at 0x2B8

# Solution

Fix lua rocks configuration, original in `"C:\Program Files (x86)\LuaRocks\config.lua"`

    rocks_trees = {
        { name = [[user]],
             root    = home..[[/luarocks]],
        },
        { name = [[system]],
             root    = [[C:\Program Files (x86)\LuaRocks\systree]],
        },
    }
    variables = {
        MSVCRT = 'MSVCR80',
        LUALIB = 'lua5.1.dll'
    }
    verbose = false   -- set to 'true' to enable verbose output

Change `LUALIB` to `[[lib\lua5.1.lib]]`

Protip: this file is read-only, so deal with that.

# Problem

You've completed all the above steps and still get the following error:
    
    busted 2.0.rc3-0 is now built and installed in C:/Users/user/AppData/Roaming/luarocks (license: MIT <http://opensource.org/licenses/MIT>)
    
    
    C:\...>busted
    'busted' is not recognized as an internal or external command,
    operable program or batch file.

# Solution

Add luarocks folder to your users path `C:\Users\<yourname>\AppData\Roaming\luarocks\bin`