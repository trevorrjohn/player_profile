require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Players' do
  get '/api/v1/players' do
    before do
      @nhlers = FactoryGirl.create_list(:player, 3, :nhl)
      @nflers = FactoryGirl.create_list(:player, 3, :nfl)
      @nbaers = FactoryGirl.create_list(:player, 3, :nba)
      @mlbers = FactoryGirl.create_list(:player, 3, :mlb)
    end

    example 'Get all players' do
      do_request

      player = json_response['players'][0]
      expect(status).to eq 200
      expect(json_response['players'].size).to eq 12
      expect(player.keys).to match_array(%w{
                                         id
                                         first_name
                                         last_name
                                         average_position_age_diff
                                         age
                                         position
                                         league
                                         name_brief
                                         })
    end
  end

  get 'api/v1/players/:id' do
    parameter :id, 'Player id'

    before do
      @player = FactoryGirl.create :player, :nhl, age: 20, position: 'C'
      FactoryGirl.create :player, :nhl, age: 30, position: 'C'
    end

    example 'Get specific player' do
      do_request id: @player.public_id

      expect(status).to eq 200
      expect(json_response['player']).to eq(
        'id' => @player.public_id,
        'first_name' => @player.first_name,
        'last_name' => @player.last_name,
        'name_brief' => "#{@player.first_name} #{@player.last_name}",
        'league' => @player.type,
        'age' => @player.age,
        'average_position_age_diff' => -5,
        'position' => @player.position)
    end
  end
end
