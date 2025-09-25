class UsersController < ActionController::Base
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

# {fact rule=os-command-injection@v1.0 defects=1}

    IO.read(File.join(file, "")) # BAD - file as first argument to File.join 

# {/fact}
# {fact rule=os-command-injection@v1.0 defects=0}

    IO.read(File.join("", file)) # GOOD - file path is sanitised by guard

# {/fact}

# {fact rule=os-command-injection@v1.0 defects=0}

    File.open(file).read # GOOD

# {/fact}

    if file == "some/const/path.txt"
# {fact rule=os-command-injection@v1.0 defects=0}

      open(file) # GOOD - file path is sanitised by guard

# {/fact}
    end

    if %w(some/const/1.txt some/const/2.txt).include? file
# {fact rule=os-command-injection@v1.0 defects=0}

      IO.read(file) # GOOD - file path is sanitised by guard

# {/fact}
    end

# {fact rule=os-command-injection@v1.0 defects=1}

    open(file) # BAD - sanity check to verify that file was not mistakenly marked as sanitized

# {/fact}
  end
end
