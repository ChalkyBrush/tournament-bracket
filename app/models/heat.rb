class Heat < ActiveRecord::Base
	belongs_to :competition

  	validates :winner_count, presence: true
  	validates :competition_id, presence: true

  	def heatFinished(competition, players)
	winnersTable = players.group_by { |r| r[:score] }
		.max_by(self.winner_count, &:first)
		.flat_map(&:last)
		.sort_by { |r| -r[:score] }
	currentHeatCount = Heat.where(round_number: self.round_number).count
	nextHeatCount = currentHeatCount/self.winner_count

	newIndex = ((self.index.to_f/self.player_count).ceil.to_i)
	p "ADDING NEW PLAYERS TO NEXT HEAT"
	p newIndex
	moveToHeat = Heat.where(round_number: self.round_number+1, index: newIndex, competition_id: competition.id).first
	p winnersTable
	if moveToHeat != nil
	  winnersTable.each do |x|
	  	Player.create!(heat_id: moveToHeat.id, gamertag: x.gamertag, competition_id: competition.id)
	  end
	else
	  winnersTable.each do |x|
	  	Player.create!(heat_id: -1, gamertag: x.gamertag, competition_id: competition.id)
	  end
	end


  	end
end