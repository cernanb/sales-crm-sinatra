class ContactsController < ApplicationController

  get '/contacts' do
    if logged_in?
      erb :"contacts/index"
    else
      redirect '/login'
    end
  end

  get '/contacts/new' do
    if logged_in?
      erb :"contacts/new"
    else
      redirect '/login'
    end
  end

  get '/contacts/:id' do
    if logged_in?
      @contact = Contact.find_by_id(params[:id])
      if @contact.household.producer_id == current_user.id
        erb :"contacts/show"
      else
        redirect "/producers/#{current_user.id}"
      end
    else
      redirect '/login'
    end
  end

  get '/contacts/:id/edit' do
    if logged_in?
      @contact = Contact.find_by_id(params[:id])
      if current_user.id == @contact.household.producer_id
        erb :"contacts/edit"
      else
        redirect "/producers/#{current_user.id}"
      end
    else
      redirect '/login'
    end
  end

  post '/contacts' do
    if params[:contact][:first_name].empty? || params[:contact][:last_name].empty? || params[:contact][:email].empty? || params[:contact][:phone_number].empty?
      erb :"/contacts/new", locals: {message: "Cannot have empty fields."}
    else
      @contact = Contact.new(params[:contact])
      @contact.save
      redirect "/households/#{params[:contact][:household_id]}"
    end
  end

  delete '/contacts/:id/delete' do
    @contact = Contact.find_by_id(params[:id])
    @contact.delete
    redirect "/households/#{@contact.household_id}"
  end

  patch '/contacts/:id' do
    @contact = Contact.find_by_id(params[:id])
    @contact.update(params[:contact])
    redirect "/contacts/#{@contact.id}"
  end

end
