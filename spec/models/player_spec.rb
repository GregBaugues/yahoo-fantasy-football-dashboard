require 'spec_helper'
require 'helpers.rb'

describe Player do

  it 'should create a player from yahoo' do
    #don't think i should use record :new_episode, but for now...
    data = yahoo_player_response
    player = Player.from_yahoo(data)
    player.should be_a Player
    player.name.should      == "John Kasay"
    player.bye_week.should  == 11
    player.team.should      == "NO"
    player.position.should  == "K"
  end

  it 'should create a player from fantasy football nerd data' do
    VCR.use_cassette('ffnerd_player') do
      data = FFNerd.player_list.first
      player = Player.from_ffn(data)
      player.should be_a Player
      player.name.should == "Derek Anderson"
      player.position.should == "QB"
      player.ffn_id.should == 2
      player.team.should == "CAR"
      player.rotoworld_key.should == "derek-anderson"
    end
  end

  it 'should merge two players that seem to be the same' do
    player1 = Player.create(name: 'Greg Baugues', position: 'QB', ffn_id: 1, team: 'CAR')
    player2 = Player.create(name: 'Greg Baugues', position: 'QB', yahoo_id: 101, team: 'CAR')
    new_player = Player.merge(player1, player2)
    new_player.ffn_id.should == 1
    new_player.yahoo_id.should == 101
  end

  it 'should not merge two players who are not the same' do
    player1 = Player.create(name: 'Greg Baugues', position: 'QB', ffn_id: 1, team: 'CAR')
    player2 = Player.create(name: 'Rachel Baugues', position: 'RB', yahoo_id: 101, team: 'CAR')
    lambda { Player.merge(player1, player2) }.should raise_error
  end

  it 'should create a player key' do
    player = Player.create(name: 'Greg Baugues', position: 'QB', ffn_id: 1, team: 'CAR')
    player.lookup_key.should == "Gr-Baugues-QB-CAR"
  end

  it 'should create a player from FFN' do

  end

end
