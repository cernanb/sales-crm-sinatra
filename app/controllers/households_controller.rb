class HouseholdsController < ApplicationController

  get '/households/new' do
    erb :"households/new"
  end

  get '/households/:id' do
    @household = Household.find_by_id(params[:id])
    if current_user.id == @household.producer_id
      erb :"households/show"
    else
      redirect "/producers/#{current_user.id}"
    end
  end

  get '/households/:id/edit' do
    @household = Household.find_by_id(params[:id])
    erb :"households/edit"
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

end
