# User login form
get "/login" do
  erb :"users/login"
end

# Authenticate user
post "/authenticate_login" do
  entered_email = params["users"]["email"]
  @user_email = User.find_by(email: entered_email)

if !@user_email.nil?
  @valid = true
  given_pw = params["users"]["password"]
  actual_pw = BCrypt::Password.new(@user_email.password)
  if actual_pw == given_pw
    session[:user_id] = @user_email.id
    erb :"users/index"
  else
    @valid = false
    erb :"users/login"
  end
else
  @valid = false
  erb :"users/login"
end
end

# List all users
get "/users" do
  if !params["log_out"].nil?
    session[:user_id] = nil
    erb :"users/index"
  end

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
  if session[:user_id] == params["users"]["id"]
    user = User.find(params["users"]["id"])
    user.delete
    redirect "users"
  else
    erb :"users/login"
  end
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
