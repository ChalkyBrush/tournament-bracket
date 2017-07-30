class Competition < ActiveRecord::Base
	validates :name, presence: true
	validates :competitor_count, presence: true
	validates :competitor_count, numericality: { greater_than: 0 }
	validates :competitors_per_heat, presence: true
	validates :competitors_per_heat, numericality: { greater_than: 0 }
	validates :winners_per_heat, presence: true
	validates :winners_per_heat, numericality: { greater_than: 0 }

  after_create(on: :create) do
  	#set current_round to 1
  	if self.current_round != 1
	  	self.current_round = 1
	  	self.save!
	end
    #create heats
    heatCount = self.competitor_count/self.competitors_per_heat
    heatCount.times do |i|
    	heat = Heat.create!(competition_id: self.id, winner_count: self.winners_per_heat, index: i+1, player_count: self.competitors_per_heat, round_number: 1)
    end
  end

  def check_round_end(heat)
  	players = Player.where(heat_id: heat.id)
  	if players.count == self.competitors_per_heat
  		allScored = true
  		players.each do |player|
  			if player.score == nil
  				allScored = false
  				break
  			end
  		end
  		if allScored
  			if heat.round_number == self.current_round
  				current_round = self.current_round
  				self.current_round = current_round + 1
  				self.save!
			    # heatCount = (self.competitor_count/self.competitors_per_heat)/((self.competitors_per_heat/self.winners_per_heat)**(current_round))
			    heatCount = Heat.where(competition_id: self.id, round_number: current_round).count * self.winners_per_heat / self.competitors_per_heat
			    p "HEAT COUNT: "+heatCount.to_s
			    heatCount.times do |i|
			    	heatNew = Heat.create!(competition_id: self.id, winner_count: self.winners_per_heat, index: i+1, player_count: self.competitors_per_heat, round_number: current_round+1)
			    end
  			end
  			heat.heatFinished(self, players)
  		end
  	else
  		return false
  	end
  end



end
