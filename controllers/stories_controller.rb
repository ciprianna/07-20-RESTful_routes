get "/users/:user_id/stories" do
  @user = User.find(params["user_id"])
  @user_stories = Story.where(user_id: @user.id)
  erb :"stories/index"
end

get "/users/:user_id/stories/new" do
  @user_id = params["user_id"]
  @new_story = Story.new
  erb :"stories/new"
end

post "/users/:user_id/stories" do
  @user_id = params["user_id"]
  title = params["stories"]["title"]
  summary = params["stories"]["summary"]
  @new_story = Story.create({"title" => title, "summary" => summary, "user_id" => @user_id})

  if @new_story.valid?
    redirect "/users/#{@user_id}/stories/#{@new_story.id}"
  else
    erb :"stories/new"
  end

end

get "/users/:user_id/stories/delete" do
  story_id = Story.find(params["stories"]["id"])
  story_id.delete
  @user_id = params["user_id"]
  redirect "/users/#{@user_id}/stories"
end

get "/users/:user_id/stories/:id/edit" do
  @story = Story.find(params["id"])
  @user_id = params["user_id"]
  erb :"stories/edit"
end

put "/users/:user_id/stories/:id" do
  @story = Story.find(params["id"])
  @story.title = params["stories"]["title"]
  @story.summary = params["stories"]["summary"]
  @story.save
  @user_id = params["user_id"]

  if !@story.valid?
    @story
    erb :"stories/edit"
  else
    redirect "/users/#{@user_id}/stories"
  end
end

get "/users/:user_id/stories/:id" do
  @story = Story.find(params["id"])
  erb :"stories/show"
end
