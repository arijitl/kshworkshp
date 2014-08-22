class Game < ActiveRecord::Base
  belongs_to :client
  has_many :rounds, dependent: :destroy
  has_many :teams, dependent: :destroy
  has_many :kauravas, dependent: :destroy

  after_create :create_teams
  after_create :create_rounds
  after_create :create_kauravas

  def create_teams
    colors=["Violet", "Indigo", "Blue", "Green", "Yellow", "Orange", "Red", "Black", "White", "Brown"]
    self.team_count.times do |index|
      Team.create!(game_id: self.id, name: colors[index], score:0)
    end
  end

  def create_rounds
    (self.round_count+1).times do |index|
      Round.create!(game_id: self.id, name: "Round #{index+1}")
    end
  end

  def create_kauravas
    karray=["Duryodhana", "Bhishma", "Drona", "Karna", "Shalya", "Dushasana", "Shakuni", "Jayadratha"]
    kparray=[9, 8, 7, 6, 4, 4, 4, 4]

    karray.each_with_index do |kau, index|
      kpower=(self.team_count*kparray[index]/3).to_i
      Kaurava.create!(game_id: self.id, name: kau, points: kparray[index], pstart: kpower, pcurrent: kpower, defeated: false)
    end
  end

end
