require 'pg'

class FooController < ActionController::Base

  def some_request_handler
    # A string tainted by user input is inserted into a query
    # (i.e a remote flow source)
    name = params[:name]

    # Establish a connection to a PostgreSQL database
    conn = PG::Connection.open(:dbname => 'postgresql', :user => 'user', :password => 'pass', :host => 'localhost', :port => '5432')

    # .exec() and .async_exec()
# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: SQL statement constructed from user input


    qry1 = "SELECT * FROM users WHERE username = '#{name}';"
    conn.exec(qry1)
    conn.async_exec(qry1)
# {/fact}
    # .exec_params() and .async_exec_params()
# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: SQL statement constructed from user input

    qry2 = "SELECT * FROM users WHERE username = '#{name}';"
    conn.exec_params(qry2)
    conn.async_exec_params(qry2)
# {/fact}

    # .exec_params() and .async_exec_params()
# {fact rule=cross-site-scripting@v1.0 defects=0}

    # GOOD: SQL statement constructed from sanitized user input

    qry2 = "SELECT * FROM users WHERE username = $1;"
    conn.exec_params(qry2, [name])
    conn.async_exec_params(qry2, [name])
# {/fact}

    # .prepare() and .exec_prepared()
# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: SQL statement constructed from user input

    qry3 = "SELECT * FROM users WHERE username = '#{name}';"
    conn.prepare("query_1", qry3)
    conn.exec_prepared('query_1')
# {/fact}

    # .prepare() and .exec_prepared()
# {fact rule=cross-site-scripting@v1.0 defects=0}

    # GOOD: SQL statement constructed from sanitized user input

    qry3 = "SELECT * FROM users WHERE username = $1;"
    conn.prepare("query_2", qry3)
    conn.exec_prepared('query_2', [name])

    # .prepare() and .exec_prepared()
    # NOT EXECUTED: SQL statement constructed from user input but not executed
    qry3 = "SELECT * FROM users WHERE username = '#{name}';"
    conn.prepare("query_3", qry3)
  end
# {/fact}
end

class BarController < ApplicationController
  def safe_paths
    name1 = params["name1"]
# {fact rule=cross-site-scripting@v1.0 defects=0}

    # GOOD: barrier guard prevents taint flow

    if name == "admin"
      qry_bar1 = "SELECT * FROM users WHERE username = '%s';" % name
    else
      qry_bar1 = "SELECT * FROM users WHERE username = 'none';"
    end
    conn.exec_params(qry_bar1)
# {/fact}

    name2 = params["name2"]
# {fact rule=cross-site-scripting@v1.0 defects=0}

    # GOOD: barrier guard prevents taint flow

    name2 = if ["admin", "guest"].include? name2
      name2
    else 
      name2 = "none"
    end
    qry_bar2 = "SELECT * FROM users WHERE username = '%s';" % name
    conn.exec_params(qry_bar2)
  end
# {/fact}
end
