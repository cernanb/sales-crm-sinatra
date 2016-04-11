class SessionsController < ApplicationController

  get '/signup' do
    erb  :"sessions/signup"
  end

  get '/login' do
    erb :"sessions/login"
  end

  get '/logout' do
    logout!
    redirect '/'
  end

  post '/signup' do
    @producer = Producer.new(params[:producer])
    if params[:producer][:name].empty? || params[:producer][:email].empty? || params[:producer][:city].empty? || params[:producer][:password].empty?
      erb :"sessions/signup", locals: {message: "Cannot have empty fields."}
    else
      if @producer.save
        session[:user_id] = @producer.id
        redirect "/producers/#{@producer.id}"
      else
        redirect '/signup'
      end
    end
  end

  post '/login' do
    if params[:producer][:email].empty? || params[:producer][:password].empty?
      erb :"sessions/login", locals: {message: "Cannot have empty fields."}
    else
      login(params[:producer][:email], params[:producer][:password])
      if logged_in?
        redirect "/producers/#{@producer.id}"
      else
        erb :"sessions/login", locals: {message: "Email or password is incorrect."}
      end
    end

  end

end
