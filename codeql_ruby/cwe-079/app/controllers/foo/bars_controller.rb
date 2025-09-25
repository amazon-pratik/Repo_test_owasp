class BarsController < ApplicationController
  helper_method :user_name, :user_name_memo

  def index
    render template: "foo/bars/index"
  end

  def user_name
    return params[:user_name]
  end

  def user_name_memo
    @user_name ||= params[:user_name]
  end

  def show
    @user_website = params[:website]
    dt = params[:text]
    @instance_text = dt
    @safe_foo = params[:text]
    @safe_foo = "safe_foo"
    @html_escaped = ERB::Util.html_escape(params[:text])
# {fact rule=autoescape-disabled@v1.0 defects=0}

    @header_escaped = ERB::Util.html_escape(cookies[:foo]) # OK - cookies not controllable by 3rd party

# {/fact}
    response.header["content-type"] = params[:content_type]
# {fact rule=autoescape-disabled@v1.0 defects=0}

    response.header["x-customer-header"] = params[:bar] # OK - header not relevant to XSS

# {/fact}
    render "foo/bars/show", locals: { display_text: dt, safe_text: "hello" }
  end

  def make_safe_html
    str = params[:user_name]
    str.html_safe
  end
end
