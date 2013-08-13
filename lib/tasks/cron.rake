desc "Gets the latest articles from Rotoworld"
task :get_articles => :environment do
  Article.get_new
end

desc "Daily maintanance"
task update: :environment do
  Team.update_rosters
  Player.reset_projections
  Projection.update_from_ffn
end