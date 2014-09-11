local fileapprover  = require 'approvals.fileapprover'
local utilities     = require 'approvals.utilities'
local path          = require 'pl.path'

local function clean_up_file ( file_path )
  if path.exists(file_path) then
    assert(os.remove(file_path))
  end
end

local function clean_up ( n, extension )
  clean_up_file(n.expected_file(extension))
  clean_up_file(n.actual_file(extension))
end

local function create_text_file_at( path, contents )
  local a = assert(io.open(path, 'w'))
  a:write(contents)
  a:close()
  return path
end

describe('verification', function()
  local namer = {
    actual_file = function ( extension )
      return utilities.adjacent_path('verification.actual' .. extension)
    end,
    expected_file = function ( extension )
      return utilities.adjacent_path('verification.expected' .. extension)
    end
  }

  local reporter = {
    report = function(self, ...)
      self.called = true
    end,
    reset = function(self)
      self.called = false
    end,
    was_called = function(self)
      return self.called
    end
  }

  local writer = {
    extension = '.txt',
    write = function( path )
      create_text_file_at(path, '12345')
    end
  }

  before_each(function()
    clean_up(namer, '.txt')
    reporter:reset()
  end)

  it( 'fails on missing expected file',  function ()
    assert.has_error(function() fileapprover.verify( writer, namer, reporter ) end,
      'Approved expectation does not exist: verification.expected.txt')
  end )

  it( 'fails when file sizes differ',  function ()
    local expected = create_text_file_at(namer.expected_file('.txt'), 'hello world')
    assert.has_error(
      function() fileapprover.verify( writer, namer, reporter ) end,
      'File sizes do not match:\r\nverification.expected.txt(11)\r\nverification.actual.txt(5)')
  end )

  it('fails when file contents differ', function ()
    local expected = create_text_file_at(namer.expected_file('.txt'),'54321')
    assert.has_error(
      function() fileapprover.verify(writer, namer, reporter) end,
      'File contents do not match:\r\nverification.expected.txt(5)\r\nverification.actual.txt(5)');
  end)

  it('passes when files are same', function ()
    local expected = create_text_file_at(namer.expected_file('.txt'),'12345')

    assert.truthy( fileapprover.verify( writer, namer, reporter ), 'verified ok');
    assert.falsy(reporter:was_called(), 'reporter not called')
  end)

  it('launches reporter on failure', function()
    create_text_file_at(namer.expected_file('.txt'), 'Helol')
    local status, err = pcall(function()
      fileapprover.verify(writer, namer, reporter)
    end)

    assert.truthy(reporter:was_called())
  end)

  it( 'Removes actual file on match', function ( )
    writer.write(namer.expected_file('.txt'))
    fileapprover.verify( writer, namer, reporter )

    assert.falsy(path.exists(namer.actual_file('.txt')))
  end)

  it( 'Preserves approved file on match', function()
    writer.write(namer.expected_file('.txt'))
    fileapprover.verify( writer, namer, reporter )

    assert.truthy(path.exists(namer.expected_file('.txt')))
  end)
end)
