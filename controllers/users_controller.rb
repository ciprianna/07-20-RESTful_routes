# User login
get "/login" do
  erb :"users/login"
end

# List all users
get "/users" do
  erb :"users/index"
end

# Create new user
get "/users/new" do
  @new_user = User.new
  erb :"users/new"
end

# Validate and save new user
post "/users" do
  email = params["users"]["email"]
  password = BCrypt::Password.create(params["users"]["password"])
  @new_user = User.create({"email" => email, "password" => password})

  if @new_user.valid?
    redirect "/users/#{@new_user.id}"
  else
    erb :"users/new"
  end

end

# Delete a user
delete "/users/delete" do
  user = User.find(params["users"]["id"])
  user.delete
  redirect "users"
end

# Edit a user
get "/users/:id/edit" do
  @user = User.find(params["id"])
  erb :"users/edit"
end

# Validate and save an existing user
put "/users/:id" do
  @user = User.find(params["id"])
  @user.email = params["users"]["email"]
  encrypted_password = BCrypt::Password.create(params["users"]["password"])
  @user.password = encrypted_password
  @user.save

  if !@user.valid?
    @user
    erb :"users/edit"
  else
    redirect "/users"
  end
end

# Show a user's information
get "/users/:id" do
  @user = User.find(params["id"])
  erb :"users/show"
end
