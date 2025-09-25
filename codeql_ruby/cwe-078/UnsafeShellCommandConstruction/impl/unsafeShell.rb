class Foobar
  def foo1(target)
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen("cat #{target}", "w") # NOT OK

# {/fact}
  end

  def foo2(x) 
# {fact rule=os-command-injection@v1.0 defects=1}

    format = sprintf("cat %s", x) # NOT OK

# {/fact}
    IO.popen(format, "w")
  end

  def fileRead1(path) 
# {fact rule=os-command-injection@v1.0 defects=0}

    File.read(path) # OK

# {/fact}
  end

  def my_exec(cmd, command, myCmd, myCommand, innocent_file_path) 
# {fact rule=os-command-injection@v1.0 defects=0}

    IO.popen("which #{cmd}", "w") # OK - the parameter is named `cmd`, so it's meant to be a command

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=0}

    IO.popen("which #{command}", "w") # OK - the parameter is named `command`, so it's meant to be a command

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=0}

    IO.popen("which #{myCmd}", "w") # OK - the parameter is named `myCmd`, so it's meant to be a command

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=0}

    IO.popen("which #{myCommand}", "w") # OK - the parameter is named `myCommand`, so it's meant to be a command

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen("which #{innocent_file_path}", "w") # NOT OK - the parameter is named `innocent_file_path`, so it's not meant to be a command

# {/fact}
  end

  def escaped(file_path)
# {fact rule=os-command-injection@v1.0 defects=0}

    IO.popen("cat #{file_path.shellescape}", "w") # OK - the parameter is escaped

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen("cat #{file_path}", "w") # NOT OK - the parameter is not escaped

# {/fact}
  end
end

require File.join(File.dirname(__FILE__), 'sub', 'other')

class Foobar2
  def foo1(target)
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen("cat #{target}", "w") # NOT OK

# {/fact}
  end

  def id(x) 
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen("cat #{x}", "w") # NOT OK - the parameter is not a constant.

# {/fact}
    return x
  end
    
  def thisIsSafe()
# {fact rule=os-command-injection@v1.0 defects=0}

    IO.popen("echo #{id('foo')}", "w") # OK - only using constants.

# {/fact}
  end    

  # class methods
  def self.foo(target)
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen("cat #{target}", "w") # NOT OK

# {/fact}
  end

  def arrayJoin(x)
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen(x.join(' '), "w") # NOT OK

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen(["foo", "bar", x].join(' '), "w") # NOT OK

# {/fact}
  end

  def string_concat(x) 
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen("cat " + x, "w") # NOT OK

# {/fact}
  end

  def array_taint (x, y)
    arr = ["cat"]
    arr.push(x)
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen(arr.join(' '), "w") # NOT OK

# {/fact}

    arr2 = ["cat"]
    arr2 << y
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen(arr.join(' '), "w") # NOT OK

# {/fact}
  end
end
