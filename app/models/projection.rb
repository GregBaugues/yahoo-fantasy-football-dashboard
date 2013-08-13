class Projection < ActiveRecord::Base
  validates_uniqueness_of :player_id, scope: :week

  def self.update_from_ffn
    week = current_week
    projections = FFNerd.projections(week)
    projections.each do |data|
      Projection.from_ffn(data)
    end
  end

  def self.from_ffn(data)
    player = Player.find_by_ffn_id(data.id)
    unless player.nil?
      Projection.delete_all(player_id: player.id, week: data.projection.week)
      data.projection[:player_id] = player.id
      Projection.create(data.projection)
      player.points = data.projection.standard
      player.save
    end
  end

  def self.current_week
    #todo make this work for seasons post 2012-2013 season
    season_start_week = 36 #what week of the year does the season start? this correct for 2012
    week_of_year = Date.today.strftime('%W').to_i
    raise 'NFL is not in season' if week_of_year < season_start_week #week 52 is last week of season
    nfl_week = week_of_year - season_start_week + 1
    nfl_week -= 1 if Date.today.monday? #Monday should be last day of prev NFL week
    nfl_week
  end

end
