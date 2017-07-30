class CompetitionsController < ApplicationController
	def view
		@competition = Competition.find(params[:id])

		render '/competition/view'
	end

	def addPlayer
	  @competition = Competition.find(params[:id])

	  name = params[:playerName]
	  heatID = params[:heatID]
	  @heat = Heat.find(heatID)
	  Player.create!(heat_id: heatID, gamertag: name)
      render :partial => '/heats/heat_table', :locals => { :heat => @heat, :competition => @competition, :round => 0}
	end

	def setScore
	  @competition = Competition.find(params[:id])

	  score = params[:score]
	  heatID = params[:heatID]
	  playerID = params[:playerID]
	  @heat = Heat.find(heatID)
	  player = Player.find(playerID)
	  player.score = score
	  player.save!
	  @competition.check_round_end(@heat)
      render :partial => '/heats/heat_table', :locals => { :heat => @heat, :competition => @competition, :round => 0}
	end

	def getRound
		@competition = Competition.find(params[:id])
		roundNumber = params[:round].to_i - 1
		p "ROUND NUMBER"
		p roundNumber
		render :partial => "/competition/round", :locals => {:competition => @competition, :i=> roundNumber}
	end
end