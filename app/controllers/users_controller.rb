class UsersController < ApplicationController

    get '/login' do
        if !logged_in?
            erb :'/login'
        else
            redirect to "/users/#{current_user.id}"
        end
    end

    post '/login' do
        user = User.find_by(username: params[:username])
        if user && user.authenticate(params[:password]) #order matters, finds user first and then authenticates password
            session[:user_id] = user.id
            redirect to "/comicbooks"
        else
            redirect to "/login"
        end
    end

    get '/signup' do
        if !logged_in?
            erb :'users/signup'
        else
            redirect to "/users/#{current_user.id}"
        end
    end

    post '/signup' do
        @user = User.new(params[:user])     #instantiating a new user
        # if user.firstname.blank? || user.lastname.blank? || user.email.blank? || user.username.blank? || user.password.blank? || User.find_by_email(params['email'])      # if any of the entry fields are blank or an already existing email address is added, it will redirect to signup
        if @user.valid?
            # binding.pry
            @user.save
            session[:user_id] = @user.id
            redirect to "/users/#{current_user.id}"
        else
            redirect to '/signup'
        end
    end

    get '/users/:id' do
        if logged_in? && params[:id].to_i  == current_user.id
            current_user #private method
            erb :'/users/index'
        else
            redirect to "/login"
        end
    end

    post '/logout' do
        session.clear
        redirect to "/login"
    end
end