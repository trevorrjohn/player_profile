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

    example 'it responds with success' do
      do_request

      expect(status).to eq 200
    end

    example 'it returns all users' do
      do_request

      expect(json_response['players'].size).to eq 12
    end

    example 'it serializes the player object' do
      do_request

      player = json_response['players'][0]

      expect(player.keys).to match_array(%w{
                                         id
                                         first_name
                                         last_name
                                         average_position_age_diff
                                         age
                                         position
                                         })
    end
  end

  get 'api/v1/players/:id' do
    before do
      @player = FactoryGirl.create :player, :nhl, age: 20, position: 'C'
      FactoryGirl.create :player, :nhl, age: 30, position: 'C'
    end

    example 'it responds with success' do
      do_request id: @player.public_id

      expect(status).to eq 200
    end

    example 'it responds with a player json' do
      do_request id: @player.public_id

      expect(json_response['player']).to eq(
        'id' => @player.public_id,
        'first_name' => @player.first_name,
        'last_name' => @player.last_name,
        'age' => @player.age,
        'average_position_age_diff' => -5,
        'position' => @player.position)
    end
  end
end
