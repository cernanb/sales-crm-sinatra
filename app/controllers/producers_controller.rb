class ProducersController < ApplicationController

  get '/producers' do
    if logged_in?
      erb :"producers/index"
    else
      redirect '/login'
    end
  end

  get '/producers/:id' do
    if logged_in?
      @producer = Producer.find_by_id(params[:id])
      if @producer
        if @producer.id == current_user.id
          erb :"producers/show"
        else
          redirect '/producers'
        end
      else
        redirect "/producers/#{current_user.id}"
      end
    else
      redirect '/login'
    end
  end

  get '/producers/:id/edit' do
    if logged_in?
      if @producer = Producer.find_by_id(params[:id])
        if @producer.id == current_user.id
          erb :"producers/edit"
        else
          redirect '/producers'
        end
      else
        redirect "/producers/#{current_user.id}"
      end
    else
      redirect '/login'
    end
  end

  patch '/producers/:id' do
    current_user.update(params[:producer])
    redirect "/producers/#{@producer.id}"
  end

  delete '/producers/:id/delete' do
    @producer = Producer.find_by_id(session[:user_id])
    @producer.contacts.each do |contact|
      contact.delete
    end
    @producer.households.each do |household|
      household.delete
    end
    @producer.delete
    logout!
  end
end
