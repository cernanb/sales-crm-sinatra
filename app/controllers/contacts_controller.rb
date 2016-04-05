class ContactsController < ApplicationController

  get '/contacts' do
    erb :"contacts/index"
  end

  get '/contacts/:id' do
    erb :"contacts/new"
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

end
