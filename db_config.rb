require 'active_record'

options = {
  adapter: 'postgresql',
  database: 'homegame'
}

ActiveRecord::Base.establish_connection(options)
