require 'oauth_util.rb'
require 'net/http'
require 'nokogiri'
require 'open-uri'

class Yahoo

  GAME_KEY      = Settings.game_key
  LEAGUE_NUMBER = Settings.league_number
  LEAGUE_KEY    = "#{GAME_KEY}.l.#{LEAGUE_NUMBER}"
  BASE_URL      = "http://fantasysports.yahooapis.com/fantasy/v2"
  LEAGUE_URL    = "#{BASE_URL}/league/#{LEAGUE_KEY}"

##############################################################
# Base methods
#
###############################################################
  def self.oAuth
    o = OauthUtil.new
    o.consumer_key = Settings.consumer_key
    o.consumer_secret = Settings.consumer_secret
    o
  end

  def self.get_xml (url)
    o = oAuth
    parsed_url = URI.parse(url)
    Net::HTTP.start(parsed_url.host) do | http |
      req = Net::HTTP::Get.new "#{ parsed_url.path }?#{ o.sign(parsed_url).query_string }"
      @response = http.request(req).body
    end
    Nokogiri::XML(@response)
  end

##############################################################################
# Retrieve raw xml from yahoo
##############################################################################

  def self.get_league_metadata
    url = "#{LEAGUE_URL}/metadata"
    doc = get_xml(url)
    get_league_metadata_from_xml(doc)
  end

  def self.get_all_players(limit = 1300)
    players_url = "#{LEAGUE_URL}/players"
    players = []

    (0..limit).step(25) do |i| #have to pull down in batches
      batch_url = "#{players_url};start=#{i};count=25"
      puts batch_url
      doc = get_xml (batch_url)
      doc.css('player').each do |player_xml|
        players << get_player_hash_from_xml(player_xml)
      end
    end

    players
  end

  #http://developer.yahoo.com/fantasysports/guide/team-resource.html
  def self.get_teams
    teams = []
    teams_url = "#{LEAGUE_URL}/teams"
    doc = get_xml (teams_url)
    doc.css('team').each do |team_xml|
      teams << get_team_hash_from_xml(team_xml)
    end

    teams
  end

  #http://developer.yahoo.com/fantasysports/guide/team-resource.html
  def self.get_players_from_team(yahoo_team_key)
    players = []
    #http://developer.yahoo.com/fantasysports/guide/team-resource.html
    team_url = "#{BASE_URL}/team/#{yahoo_team_key}/roster"
    doc = get_xml (team_url)
    doc.css('player').each do |player_xml|
      players << get_player_hash_from_xml(player_xml)
    end

    players
  end

##############################################################################
# Turn raw XML into hashes
##############################################################################

  def self.get_team_hash_from_xml(xml)
    {
      yahoo_key:  xml.css('team_key').inner_html,
      yahoo_id:   xml.css('team_id').inner_html,
      name:       xml.css('name').inner_html,
    }
  end

  def self.get_player_hash_from_xml(xml)
    {
      yahoo_id:    xml.css('player_id').inner_html.to_i,
      yahoo_key:   xml.css('player_key').inner_html,
      first_name:  xml.css('ascii_first').inner_html,
      last_name:   xml.css('ascii_last').inner_html,
      bye_week:    xml.css('bye_weeks/week').inner_html.to_i,
      position:    xml.css('display_position').inner_html,
      active:      xml.css('selected_position/position').inner_html == "BN" ? false : true,
      team:        xml.css('editorial_team_abbr').inner_html.upcase
    }
  end

  def self.get_league_metadata_from_xml(xml)
    {
      league_key:     LEAGUE_KEY,
      league_name:    xml.css('name').inner_html,
      current_week:   xml.css('current_week').inner_html,
      game_key:       GAME_KEY,
      league_number:  LEAGUE_NUMBER
    }
  end

end