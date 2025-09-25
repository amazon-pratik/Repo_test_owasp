class UserGroup < ActiveRecord::Base
  has_many :users
end

class User < ApplicationRecord
  belongs_to :user_group

  def self.authenticate(name, pass)
# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: possible untrusted input interpolated into SQL fragment


    find(:first, :conditions => "name='#{name}' and pass='#{pass}'")
  end
# {/fact}

  def self.from(user_group_id)
# {fact rule=cross-site-scripting@v1.0 defects=0}

    # GOOD: `find_by` with hash argument

    UserGroup.find_by(id: user_group_id).users
  end
end
# {/fact}

class Admin < User
  def self.delete_by(condition = nil)
# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: `delete_by overrides an ActiveRecord method, but doesn't perform

    # any validation before passing its arguments on to another ActiveRecord method
    destroy_by(condition)
  end
end
# {/fact}

class FooController < ActionController::Base

  MAX_USER_ID = 100_000

  # A string tainted by user input is inserted into an SQL query
  def some_request_handler
# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `SELECT AVG(#{params[:column]}) FROM "users"`

    # where `params[:column]` is unsanitized
    User.calculate(:average, params[:column])
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `SELECT MAX(#{params[:column]}) FROM "users"`

    # where `params[:column]` is unsanitized
    User.maximum(params[:column])
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `DELETE FROM "users" WHERE (id = '#{params[:id]}')`

    # where `params[:id]` is unsanitized
    User.delete_by("id = '#{params[:id]}'")
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `DELETE FROM "users" WHERE (id = '#{params[:id]}')`

    # where `params[:id]` is unsanitized
    # (in Rails < 4.0)
    User.delete_all("id = '#{params[:id]}'")
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `SELECT "users".* FROM "users" WHERE (id = '#{params[:id]}')`

    # where `params[:id]` is unsanitized
    User.destroy_by(["id = '#{params[:id]}'"])
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `SELECT "users".* FROM "users" WHERE (id = '#{params[:id]}')`

    # where `params[:id]` is unsanitized
    # (in Rails < 4.0)
    User.destroy_all(["id = '#{params[:id]}'"])
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `SELECT "users".* FROM "users" WHERE id BETWEEN '#{params[:min_id]}' AND 100000`

    # where `params[:min_id]` is unsanitized
    User.where(<<-SQL, MAX_USER_ID)
      id BETWEEN '#{params[:min_id]}' AND ?
    SQL
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: chained method case

    # executes `SELECT "users".* FROM "users" WHERE (NOT (user_id = 'params[:id]'))`
    # where `params[:id]` is unsanitized
    User.where.not("user.id = '#{params[:id]}'")

    User.authenticate(params[:name], params[:pass])
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `SELECT "users".* FROM "users" WHERE (id = '#{params[:id]}')` LIMIT 1

    # where `params[:id]` is unsanitized
    User.find_or_initialize_by("id = '#{params[:id]}'")
# {/fact}

    user = User.first
# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `SELECT "users".* FROM "users" WHERE id = 1 LIMIT 1 #{params[:lock]}`

    # where `params[:lock]` is unsanitized
    user.reload(lock: params[:lock])
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `SELECT #{params[:column]} FROM "users"`

    # where `params[:column]` is unsanitized
    User.select(params[:column])
    User.reselect(params[:column])
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `SELECT "users".* FROM "users" WHERE (#{params[:condition]})`

    # where `params[:condition]` is unsanitized
    User.rewhere(params[:condition])
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `UPDATE "users" SET #{params[:fields]}`

    # where `params[:fields]` is unsanitized
    User.update_all(params[:fields])
    
    User.reorder(params[:direction])
    
    User.count_by_sql(params[:custom_sql_query])
  end
end
# {/fact}

class BarController < ApplicationController
  def some_other_request_handler
    ps = params
    uid = ps[:id]
    uidEq = "= '#{uid}'"

# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: executes `DELETE FROM "users" WHERE (id = #{uid})`

    # where `uid` is unsantized
    User.delete_by("id " + uidEq)
  end
# {/fact}

  def safe_paths
    dir = params[:order]
# {fact rule=cross-site-scripting@v1.0 defects=0}

    # GOOD: barrier guard prevents taint flow

    if dir == "ASC"
      User.order("name #{dir}")
    else
      dir = "DESC"
      User.order("name #{dir}")
    end
    # TODO: a more idiomatic form of this guard is the following:
    #     dir = "DESC" unless dir == "ASC"
    # but our taint tracking can't (yet) handle that properly

    name = params[:user_name]
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=0}

    # GOOD: barrier guard prevents taint flow


    if %w(alice bob charlie).include? name
      User.find_by("username = #{name}")
    end
# {/fact}
    name = params[:user_name]
# {fact rule=cross-site-scripting@v1.0 defects=0}

    # GOOD: hash arguments are sanitized by ActiveRecord


    User.find_by(user_name: name)
# {/fact}

# {fact rule=cross-site-scripting@v1.0 defects=0}

    # OK: `find` method is overridden in `User`


    User.find(params[:user_group])
  end
# {/fact}
end

class BazController < BarController
  def yet_another_handler
    Admin.delete_by(params[:admin_condition])
  end
end

class AnnotatedController < ActionController::Base
  def index
    name = params[:user_name]
# {fact rule=cross-site-scripting@v1.0 defects=0}

    # GOOD: string literal arguments not controlled by user are safe for annotations


    users = User.annotate("this is a safe annotation").find_by(user_name: name)
  end
# {/fact}

  def unsafe_action
    name = params[:user_name]
# {fact rule=cross-site-scripting@v1.0 defects=1}

    # BAD: user input passed into annotations are vulnerable to SQLi


    users = User.annotate("this is an unsafe annotation:#{params[:comment]}").find_by(user_name: name)
  end
# {/fact}
end

# A regression test

class Regression < ActiveRecord::Base
end

class RegressionController < ActionController::Base
  def index
    my_params = permitted_params
    query = "SELECT * FROM users WHERE id = #{my_params[:user_id]}"
    result = Regression.find_by_sql(query)
  end

  
  def permitted_params
    params.require(:my_key).permit(:id, :user_id, :my_type)
  end
  
  def show
    ActiveRecord::Base.connection.execute("SELECT * FROM users WHERE id = #{permitted_params[:user_id]}")
    Regression.connection.execute("SELECT * FROM users WHERE id = #{permitted_params[:user_id]}")
  end
end