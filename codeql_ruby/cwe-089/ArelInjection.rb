
class PotatoController < ActionController::Base
  def unsafe_action
    name = params[:user_name]
# {fact rule=cross-site-scripting@v1.0 defects=1}
    # BAD: SQL statement constructed from user input

    sql = Arel.sql("SELECT * FROM users WHERE name = #{name}")
  end
# {/fact}
end