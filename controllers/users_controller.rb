get "/users" do
  erb :"users/index"
end

get "/users/new" do
  @new_user = User.new
  erb :"users/new"
end

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

get "/users/delete" do
  erb :"users/delete"
end

delete "/users/:id" do
  user = User.find(params["id"])
  user.delete
  redirect "users"
end

get "/users/:id/edit" do
  @user = User.find(params["id"])
  erb :"users/edit"
end

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

get "/users/:id" do
  erb "show"
end
