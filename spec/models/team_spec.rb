require 'spec_helper'
require 'helpers.rb'

describe Team do

  it 'should create a team from yahoo' do
    team = Team.from_yahoo(yahoo_team_response)
    team.should be_a Team
  end

  # it 'should update a roster' do
  #   Yahoo.stub(:get_players_from_yahoo).and_return([yahoo_player_response])
  #   team = Team.from_yahoo(yahoo_team_response)
  #   team.update_roster
#   Player.where(team_id: team.id).count.should_not eq 0
  # end

  it 'should pull a team in display order' do
    with_fake_team do
      players = @team.active
      players.first.position.should == 'QB'
      players.last.position.should == 'DEF'
      players.size.should == 9
    end
  end

  it 'should display the bench' do
    with_fake_team do
      bench = @team.bench
      bench.first.position.should == 'QB'
      bench.size.should == 6
    end
  end

  it 'should sum the points' do
    with_fake_team do
      @team.active_points.should == 90
    end
  end

  it 'should identify the worst players' do
    with_fake_team do
      Player.create(team_id: @team.id, position: 'QB', name: 'A. Suck', yahoo_id: 99, points: 5)
      @team.worst_players.first.name.should == 'A. Suck'
    end
  end

  it 'should find a better free agent' do
    with_fake_team do
      Player.create(team_id: nil, position: 'QB', name: 'A. Awesome', yahoo_id: 99, points: 20)
      replacements = @team.better_free_agents
      puts replacements.inspect
      replacements.first.name.should == 'A. Awesome'
    end
  end

end
