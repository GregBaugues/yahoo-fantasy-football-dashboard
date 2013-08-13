def yahoo_player_response
  {
    :yahoo_player_id=>1111,
    :yahoo_player_key=>"257.p.1111",
    :first_name=>"John",
    :last_name=>"Kasay",
    :bye_week=>"11",
    :position=>"K",
    :active_status=>"active",
    :team_abbr=>"NO"
  }
end

def yahoo_team_response
  {
    yahoo_key:  "xxxxx.l.xxxxx.t.1",
    yahoo_id:   1,
    name:       "Fighting Madisons"
  }
end

def with_fake_team
  @team = Team.create(name: 'Test Team')
  Player.create(name: 'J. Charles', position: 'RB',   active: true, yahoo_id: 1)
  Player.create(name: 'A. Rodgers', position: 'QB',   active: true, yahoo_id: 2)
  Player.create(name: 'R. Rice',    position: 'RB',   active: true, yahoo_id: 3)
  Player.create(name: 'M. Manning', position: 'WR',   active: true, yahoo_id: 4)
  Player.create(name: 'J. Players', position: 'WR',   active: true, yahoo_id: 15)
  Player.create(name: 'D. Akers',   position: 'K',    active: true, yahoo_id: 5)
  Player.create(name: 'Gronkowski', position: 'TE',   active: true, yahoo_id: 6)
  Player.create(name: 'San Fran',   position: 'DEF',  active: true, yahoo_id: 7)
  Player.create(name: 'M. Vick',    position: 'QB',   active: false, yahoo_id: 8)
  Player.create(name: 'C. Spiller', position: 'RB',   active: false, yahoo_id: 9)
  Player.create(name: 'V. Cruz',    position: 'WR',   active: true, yahoo_id: 10)
  Player.create(name: 'G. Baugue',  position: 'RB',   active: false, yahoo_id: 11)
  Player.create(name: 'B. Wallce',  position: 'TE',   active: false, yahoo_id: 12)
  Player.create(name: 'D. Golden',  position: 'TE',   active: false, yahoo_id: 13)
  Player.create(name: 'D. Rodgers', position: 'RB',   active: false, yahoo_id: 14)
  Player.update_all(team_id: @team.id, points: 10)
  yield
  Player.destroy_all
  Team.destroy_all
end
