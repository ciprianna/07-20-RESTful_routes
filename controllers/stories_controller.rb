# List a user's stories
get "/users/:user_id/stories" do
  @user = User.find(params["user_id"])
  @user_stories = Story.where(user_id: @user.id)
  if @user.id == session[:user_id]
    @current_user = true
  else
    @current_user = false
  end
  erb :"stories/index"
end

# Create a new story for a user
get "/new_story" do
  @user = User.find(session[:user_id])
  @new_story = Story.new
  erb :"stories/new"
end

# Validate and save the new story for a user
post "/users/:user_id/stories" do
  @user = User.find(session[:user_id])
  title = params["stories"]["title"]
  summary = params["stories"]["summary"]
  @new_story = Story.create({"title" => title, "summary" => summary, "user_id" => @user.id})

  if @new_story.valid?
    redirect "/users/#{@user.id}/stories/#{@new_story.id}"
  else
    erb :"stories/new"
  end

end

# Delete a user's story
delete "/delete_story" do
  @user = User.find(session[:user_id])
  story_id = Story.find(params["stories"]["id"])
  story_id.delete
  redirect "/users/#{@user.id}/stories"
end

# Edit a user's story
get "/edit_story" do
    @user = User.find(session[:user_id])
    @story = Story.find(params["stories"]["id"])
    erb :"stories/edit"
end

# Validate and save an existing user's story
put "/users/:user_id/stories/:id" do
  @user = User.find(session[:user_id])
  @story = Story.find(params["id"])
  @story.title = params["stories"]["title"]
  @story.summary = params["stories"]["summary"]
  @story.save

  if !@story.valid?
    @story
    erb :"stories/edit"
  else
    redirect "/users/#{@user.id}/stories"
  end
end

# Show a user's story's information
get "/users/:user_id/stories/:id" do
  @story = Story.find(params["id"])
  erb :"stories/show"
end
