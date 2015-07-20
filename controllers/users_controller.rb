get "/users" do
  erb :"users/index"
end

get "/users/new" do
  erb :"users/new"
end

post "/users" do
  @new_user = User.new
  email = params["users"]["email"]
  password = Bcrypt::Password.create(params["users"]["password"])
  @new_user = User.create({"email" => email, "password" => password})

  if @new_user.valid?
    redirect "/users/#{@new_user.id}"
  else
    erb :"users/new"
  end

end

delete "/users/:id" do
end

get "/users/:id/edit" do
  erb :"users/edit"
end

put "users/:id" do
end

get "users/:id" do
end
