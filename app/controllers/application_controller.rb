require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'session_secret_comicbook'     #prevents information to be tamperred with
    register Sinatra::Flash
  end

  get "/" do
    if logged_in?
      redirect to "/users/#{current_user.id}"
    else
      erb :'/users/login'
    end
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in?
      !!current_user
    end
  end

private                             #private methods can only be called inside another method
def redirect_if_not_logged_in
    if !logged_in?
      redirect to "/login"
  end
end

end
