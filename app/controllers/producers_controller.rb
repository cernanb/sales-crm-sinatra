class ProducersController < ApplicationController

  get '/producers' do
    erb :"producers/index"
  end

  get '/producers/:id' do
    @producer = Producer.find_by_id(params[:id])
    if session[:user_id] == @producer.id
      erb :"producers/show"
    else
      redirect '/producers'
    end
  end

  get '/producers/:id/edit' do
    @producer = Producer.find_by_id(session[:user_id])
    erb :"producers/edit"
  end

  patch '/producers/:id' do
    @producer = Producer.find_by_id(session[:user_id])
    @producer.update(params[:producer])
    redirect "/producers/#{@producer.id}"
  end
end
