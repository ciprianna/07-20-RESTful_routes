get "/users" do
  erb :"users/index"
end

get "/users/new" do
  erb :"users/new"
end

post "/users" do
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