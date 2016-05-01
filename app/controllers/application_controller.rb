class ApplicationController < Sinatra::Base

  set :views, Proc.new { File.join(root, "../views/") }
  register Sinatra::Twitter::Bootstrap::Assets

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    def valid_fields?(params)
      params[:contact][:first_name].empty? || params[:contact][:last_name].empty? || params[:contact][:email].empty? || params[:contact][:phone_number].empty?
    end

    def logged_in?
      !!current_user
    end

    def current_user
      @current_user ||= Producer.find_by_id(session[:user_id])
    end

    def logout!
      session.clear
      redirect '/'
    end

    def login(email, password)
      @producer = Producer.find_by(email: email)
      if @producer && @producer.authenticate(password)
        session[:user_id] = @producer.id
      end
    end
  end

end
