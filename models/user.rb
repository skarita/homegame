class User < ActiveRecord::Base
   has_secure_password
   belongs_to :user_type
   belongs_to :game
   has_many :reservations
end
