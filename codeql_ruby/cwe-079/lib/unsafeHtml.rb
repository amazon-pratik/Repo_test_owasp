class Foobar
  def create_user_description(name)
# {fact rule=autoescape-disabled@v1.0 defects=1}

    "<h2>#{name}</h2>".html_safe # NOT OK - the parameter is not escaped

# {/fact}

    # escape
# {fact rule=autoescape-disabled@v1.0 defects=0}

    "<h2>#{ERB::Util.html_escape(name)}</h2>".html_safe # OK - the parameter is escaped

# {/fact}
  end

  def string_like_literal name
    h = <<-HTML
        <h2>#{name}</h2>
    HTML
# {fact rule=autoescape-disabled@v1.0 defects=1}

    h.html_safe # NOT OK - the parameter is not escaped

# {/fact}
  end

  def sprintf_use name
# {fact rule=autoescape-disabled@v1.0 defects=1}

    sprintf("<h2>%s</h2>", name).html_safe # NOT OK - the parameter is not escaped

# {/fact}

    # escape
# {fact rule=autoescape-disabled@v1.0 defects=0}

    sprintf("<h2>%s</h2>", ERB::Util.html_escape(name)).html_safe # OK - the parameter is escaped

# {/fact}
  end
end
