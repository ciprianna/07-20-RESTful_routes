# Creates the database connection

# Development
configure :development do
  require "sqlite3"
  ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'stories.db')
end

# Production
configure :production do
  require "pg"
  db = URI.parse(ENV['DATABASE_URL'])

  ActiveRecord::Base.establish_connection(
    :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
    :host     => db.host,
    :username => db.user,
    :password => db.password,
    :database => db.path[1..-1],
    :encoding => 'utf8'
  )
end

# users table
unless ActiveRecord::Base.connection.table_exists?(:users)
  ActiveRecord::Base.connection.create_table :users do |table|
    table.text :email
    table.text :password
  end
end

# stories table
unless ActiveRecord::Base.connection.table_exists?(:stories)
  ActiveRecord::Base.connection.create_table :stories do |table|
    table.text :title
    table.text :summary
    table.integer :user_id
  end
end

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
