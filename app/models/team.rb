class Team < ActiveRecord::Base
  belongs_to :game
  has_many :pandavas, dependent: :destroy

  after_create :create_pandavas

  def create_pandavas
    parray=["Arjuna", "Bhima","Yudhishthira", "Nakula-Sahadeva", "Ghatothkach", "Abhimanyu", "Dhrishtadyumna", "Satyaki"]
    pparray=[5, 4, 3, 2, 1, 1, 1, 1]

    parray.each_with_index do |pan, index|
      Pandava.create!(team_id: self.id, name: pan, attack: pparray[index], used: false)
    end
  end

end
