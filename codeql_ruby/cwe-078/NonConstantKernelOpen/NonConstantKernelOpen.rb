class UsersController < ActionController::Base
  CONSTANT = "constant"
  CONSTANT_WITH_FREEZE = "constant-with-freeze".freeze

  def create
    file = params[:file]
# {fact rule=os-command-injection@v1.0 defects=1}

    open(file) # BAD

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.read(file) # BAD

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.write(file) # BAD

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.binread(file) # BAD

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.binwrite(file) # BAD

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.foreach(file) # BAD

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.readlines(file) # BAD

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=1}

    URI.open(file) # BAD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    File.open(file).read # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=1}

    Kernel.open(file) # BAD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    File.open(file, "r") # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    Kernel.open("constant") # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    IO.read("constant") # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    Kernel.open("this is #{fine}") # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=1}

    Kernel.open("#{this_is} bad") # BAD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    open("| #{this_is_an_explicit_command} foo bar") # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    IO.foreach("|" + EnvUtil.rubybin + " -e 'puts :foo; puts :bar; puts :baz'") {|x| a << x } # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    IO.write(File.join("foo", "bar.txt"), "bar") # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    IO.read(CONSTANT) # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    IO.read(CONSTANT + file) # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    IO.read(CONSTANT_WITH_FREEZE) # GOOD

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    IO.read(CONSTANT_WITH_FREEZE + file) # GOOD

# {/fact}
    
# {fact rule=os-command-injection@v1.0 defects=0}

    open.where(external: false) # GOOD - an open method is called withoout arguments

# {/fact}
    
# {fact rule=os-command-injection@v1.0 defects=1}

    open(file) # BAD - sanity check to verify that file was not mistakenly marked as sanitized

# {/fact}
  end
end
