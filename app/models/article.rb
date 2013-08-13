class Article < ActiveRecord::Base
  validates_uniqueness_of :title

  def self.get_new
    doc = Nokogiri::XML(open('http://www.rotoworld.com/rss/feed.aspx?sport=nfl&ftype=news&count=50&format=rss'))
    doc.css('item').each do |item|
      article = from_rotoworld(item)
      article.save
    end
  end

  def self.from_rotoworld(item)
    full_title = item.css('title').inner_html
    article = Article.new(
      title:        full_title.match(/(.+)\s\-/)[1],
      link:         item.css('link').inner_html,
      description:  item.css('description').inner_html
    )
    article.match_player(full_title)
    article
  end

  def match_player(full_title)
    name = full_title.match(/\-\s(.+)\|/)[1].strip!
    team = full_title.match(/\|\s([A-Z]{2,3})/)[1]
    player = Player.where(name: name, team: team).first
    self.player_id = player.id unless player.nil?
  end

  def player
    player_id.nil? ? nil : Player.find(player_id)
  end


end
