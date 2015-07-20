# General
require "pry"
require "sinatra"
require "sinatra/reloader"
require "bcrypt"
require "active_record"

# Database
require_relative "database_setup.rb"

# Models
require_relative "models/user.rb"
require_relative "models/story.rb"

# Controllers
require_relative "controllers/users_controller.rb"
require_relative "controllers/stories_controller.rb"
