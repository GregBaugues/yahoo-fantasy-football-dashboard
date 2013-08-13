class Team < ActiveRecord::Base
  has_many :players, order: "active DESC, position ASC"
  validates_uniqueness_of :yahoo_id

  #only use this if shit went really bad
  # def self.start_over
  #   Player.delete_all
  #   Team.delete_all
  #   Projection.delete_all
  #   Player.all_from_yahoo
  #   Team.update_from_yahoo
  #   Projection.update_from_ffn(1)
  # end

  def self.update_from_yahoo
    Yahoo::get_teams.each do |data|
      team = Team.from_yahoo(data)
      team.update_roster
    end
  end

  def self.from_yahoo(data)
    team = Team.find_or_create_by_yahoo_id(data[:yahoo_id])
    team.update_attributes(data)
    team
  end

  def self.update_rosters
    Team.update_from_yahoo
    Team.all.each { |team| team.update_roster }
  end

  def update_roster
    release_players
    players = Yahoo::get_players_from_team(yahoo_key)
    players.each do |data|
      player = Player.find_by_yahoo_id(data[:yahoo_id])
      if player.nil?
        data[:team_id] = id #set relationship between player and team
        data[:name]    = "#{data[:first_name]} #{data[:last_name]}"
        Player.create(data)
      else
        player.team_id = id
        player.active = data[:active]
        player.save
      end
    end
  end

  #releases all players from a team back into the field
  def release_players
    Player.where(team_id: id).update_all(team_id: nil, active: false)
  end

  def active
    in_display_order(players.where(active: true).order('points DESC'))
  end

  def bench
    in_display_order(players.where(active: false).order('points DESC'))
  end


  def to_s
    string = "#{name}: "
    players.map { |player| string += "#{player.name}, " }
    string
  end

  def active_points
    players.where(active: true).sum('points').round(1)
  end

  def worst_players
    positions = %w{ QB WR RB TE K DEF }
    worst = []
    positions.each do |position|
      worst += Player.where(team_id: id, position: position).order('points ASC').limit(1)
    end
    worst
  end

  def better_free_agents
    replacements = []
    worst_players.each do |p|
      replacements += Player.where(['team_id IS NULL and position = ? and points >= ?', p.position, p.points]).order('points DESC').limit(3)
    end
    replacements
  end


  def articles
    articles = []
    players.each do |player|
      article = player.articles.limit(1).first
      articles << article unless article.nil?
    end
    articles.sort! { |a, b| b.created_at <=> a.created_at }
  end

  private

  def in_display_order(players)
    ordered_players = []
    order = %W{ QB WR RB TE K DEF }
    order.each do |position|
      players.each { |p| ordered_players << p if p.position == position }
    end
    ordered_players
  end


end
