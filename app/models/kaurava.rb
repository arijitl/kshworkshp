class Kaurava < ActiveRecord::Base
  belongs_to :game
  has_many :pandavas
end
