class Foobar
  def foo1(target)
# {fact rule=os-command-injection@v1.0 defects=1}

    IO.popen("cat #{target}", "w") # NOT OK - everything assumed to be imported...

# {/fact}
  end
end
  