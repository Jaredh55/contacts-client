class Client::ContactsController < ApplicationController
def index
    response = Unirest.get("http://localhost:3000/api/contacts")
    @contacts = response.body
     #no database, must reference other side
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    client_params = {
                        title: params[:title],
                        chef: params[:chef],
                        ingredients: params[:ingredients],
                        directions: params[:directions],
                        prep_time: params[:prep_time]
                      }
    response = Unirest.post(
                            "http://localhost:3000/api/contacts", parameters: client_params
                            )
    render 'create.html.erb'
  end

  def show
    contact_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/contact/#{contact_id}")
    @contact = response.body #hash
    render 'show.html.erb'
  end

  def edit
    @contact_id = params[:id]
    response = Unirest.get("http://localhost:3000/api/contacts/#{@contact_id}")
    @contact = response.body
    render 'edit.html.erb'
  end

  def update
        client_params = {
                        title: params[:title],
                        chef: params[:chef],
                        ingredients: params[:ingredients],
                        directions: params[:directions],
                        prep_time: params[:prep_time]
                      }
        response = Unirest.patch(
                             "http://localhost:3000/api/contacts/#{ params[:id] }",
                             parameters: client_params
                            )
        render 'update.html.erb'
  end

  def destroy
    contact_id = params[:id]
    response = Unirest.delete("http://localhost:3000/api/contacts/#{ contact_id }")
    render 'destroy.html.erb'
  end


end
