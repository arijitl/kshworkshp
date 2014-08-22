class RoundsController < ApplicationController
  def show
    @round=Round.find(params[:id])
    @game=@round.game
    @commanders=@game.kauravas.where(defeated: false).where("points>?", 4).all
    @defcommanders=@game.kauravas.where(defeated: true).where("points>?", 4).all
    @warriors=@game.kauravas.where(defeated: false).where("points<?", 5).all
    @defwarriors=@game.kauravas.where(defeated: true).where("points<?", 5).all
    @teams=@game.teams
  end

  def reset
    game=Game.find(params[:id])
    client=game.client_id
    gname= game.name
    rndcnt=game.round_count
    teamcnt=game.team_count
    game.destroy
    newgame=Game.create(client_id: client, name: gname, round_count: rndcnt, team_count: teamcnt, complete: false)
    redirect_to newgame.rounds.first
  end

  def attacking
    kaurava=Kaurava.find(params[:kid])
    pandava_ids=params[:pset].split("-")
    pandavas=[]
    pandava_ids.each do |id|
      pandavas<<Pandava.find(id.to_i)
    end
    totalattack=pandavas.map { |p| p.attack }.sum
    kaurava.pcurrent=kaurava.pcurrent-totalattack
    pandavas.each do |p|
      p.kaurava_id=params[:kid]
      p.used=true
      p.victory = (kaurava.pcurrent<1) ? true : false
      p.save
    end
    if kaurava.pcurrent<1
      kaurava.defeated=true
      pandavas.map{|p| p.team}.uniq.each do |t|
        t.score+=kaurava.points
        t.save
      end
    end
    kaurava.save
    render text: "#{kaurava.defeated ? "Victory" : "Not Enough"}||#{kaurava.name} was attacked by #{pandavas.map { |p| [p.team.name, p.name].join(" - ") }.join(", ")} for #{totalattack} #{(kaurava.pcurrent<1) ? ' and was defeated' : ', but survived'}"
  end

  def teamdissect
    team = Team.find(params[:id])
    pandavas=team.pandavas
    message=[]
    message<< "<h3 style='margin:0;padding:5px;border: 2px solid #{team.name}'>Score: #{team.score} after using #{pandavas.where(used: true).map { |p| p.attack }.sum}/18 attack</h3>"

    pandavas.where(used: true).each do |p|
      if p.victory
        message << "<span style='color:darkgreen'><strong>#{p.name}</strong> attacked <strong>#{p.kaurava.name}</strong> and defeated him</span>"
      else
        message << "<span style='color:darkred'><strong>#{p.name}</strong> attacked <strong>#{p.kaurava.name}</strong> but could not defeat him</span>"
      end
    end
    message<<"<hr/>"
    pandavas.where(used: false).each do |p|
      message << "#{p.name} hasn't fought yet"
    end
    render text: message.join("||")

  end

end
