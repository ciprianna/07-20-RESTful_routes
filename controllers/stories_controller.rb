get "/users/:user_id/stories" do
end

get "/users/:user_id/stories/new" do
  @new_story = Story.new
  erb :"stories/new"
end

post "/users/:user_id/stories" do
  title = params["stories"]["title"]
  summary = params["stories"]["summary"]
  @new_story = Story.create({"title" => title, "summary" => summary})

  if @new_story.valid?
    redirect "/users/:user_id/stories/#{@new_story.id}"
  else
    erb :"stories/new"
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
  @user = User.find(params["id"])
  erb :"users/show"
end
