require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'homegame'
}

ActiveRecord::Base.establish_connection( ENV['DATABASE_URL'] || options)
