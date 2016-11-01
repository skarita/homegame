class Reservation < ActiveRecord::Base
   has_many :users
   has_many :games
end
