class HouseholdsController < ApplicationController

  get '/households/new' do
    if logged_in?
      erb :"households/new"
    else
      redirect '/login'
    end
  end

  get '/households/:id' do
    if logged_in?
      @household = Household.find_by_id(params[:id])
      if current_user.id == @household.producer_id
        erb :"households/show"
      else
        redirect "/producers/#{current_user.id}"
      end
    else
      redirect '/login'
    end
  end

  get '/households/:id/edit' do
    if logged_in?
      @household = Household.find_by_id(params[:id])
      if @household.producer_id == current_user.id
        erb :"households/edit"
      else
        redirect "producers/#{current_user.id}"
      end
    else
      redirect '/login'
    end
  end

  post '/households' do
    if params[:household][:name].empty? || params[:household][:revenue].empty? || params[:household][:address].empty?
      erb :"households/new", locals: {message: "Cannot have empty fields."}
    else
      @household = current_user.households.build(params[:household])
      @household.save
      redirect "/producers/#{current_user.id}"
    end
  end

  patch '/households/:id' do
    @household = Household.find_by_id(params[:id])
    @household.update(params[:household])
    redirect "/households/#{@household.id}"
  end

  delete '/households/:id/delete' do
    @household = Household.find_by_id(params[:id])
    @household.contacts.each do |contact|
      contact.delete
    end
    @household.delete
    redirect "/producers/#{current_user.id}"
  end

end
