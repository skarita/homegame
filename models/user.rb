class User < ActiveRecord::Base
   has_secure_password
   belongs_to :user_type
   has_many :games
   has_many :reservations
end
