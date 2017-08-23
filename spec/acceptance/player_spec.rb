require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'GET Player#show' do
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
        'photo_url' => @player.photo_url,
        'team' => @player.team,
        'position' => @player.position)
    end
  end
end
