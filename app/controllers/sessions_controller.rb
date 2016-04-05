class SessionsController < ApplicationController

  get '/signup' do
    erb  :"sessions/signup"
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

  get '/login' do
    erb :"sessions/login"
  end

  post '/signup' do
    @producer = Producer.new(params[:producer])
    # binding.pry
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
    @producer = Producer.find_by(email: params[:producer][:email])
    if @producer && @producer.authenticate(params[:producer][:password])
      session[:user_id] = @producer.id
      redirect "/producers/#{@producer.id}"
    else
      erb :"/sessions/login", locals: {message: "Email or password is incorrect."}
    end
  end

end
