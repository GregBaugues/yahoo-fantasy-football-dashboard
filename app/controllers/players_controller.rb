class PlayersController < ApplicationController

  def index
    @players = Player.order('points DESC').limit(250)
    @rank = 0
  end

end