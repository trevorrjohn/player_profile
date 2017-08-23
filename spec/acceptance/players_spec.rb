require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'Players' do
  parameter :league, 'league name eg. [NHL, NFL, MLB, NHL]', required: true
  get '/api/v1/players' do
    before do
      @nhlers = FactoryGirl.create_list(:player, 3, :nhl)
      @nflers = FactoryGirl.create_list(:player, 3, :nfl)
      @nbaers = FactoryGirl.create_list(:player, 3, :nba)
      @mlbers = FactoryGirl.create_list(:player, 3, :mlb)
    end

    example 'invalid parameter' do
      do_request
      expect(status).to eq 422
      expect(json_response).to eq('error' => 'Invalid league parameter')
    end

    example 'Get NBA players' do
      do_request league: 'NBA'

      player = json_response['players'][0]
      expect(status).to eq 200
      expect(json_response['players'].size).to eq 3
      expect(player.keys).to match_array(%w{
                                         id
                                         first_name
                                         last_name
                                         average_position_age_diff
                                         age
                                         position
                                         league
                                         team
                                         photo_url
                                         name_brief
                                         })
    end

    example 'Get NHL players' do
      do_request league: 'NHL'

      player = json_response['players'][0]
      expect(status).to eq 200
      expect(json_response['players'].size).to eq 3
      expect(player.keys).to match_array(%w{
                                         id
                                         first_name
                                         last_name
                                         average_position_age_diff
                                         age
                                         position
                                         league
                                         team
                                         photo_url
                                         name_brief
                                         })
    end

    example 'Get NFL players' do
      do_request league: 'NFL'

      player = json_response['players'][0]
      expect(status).to eq 200
      expect(json_response['players'].size).to eq 3
      expect(json_response['players'].map{ |x| x['league'] }.uniq)
        .to eq ['NFL']
      expect(player.keys).to match_array(
        %w[
           id
           first_name
           last_name
           average_position_age_diff
           age
           position
           league
           team
           photo_url
           name_brief
      ])
    end

    example 'Get MLB players' do
      do_request league: 'MLB'

      player = json_response['players'][0]
      expect(status).to eq 200
      expect(json_response['players'].size).to eq 3
      expect(player.keys).to match_array(
        %w[
           id
           first_name
           last_name
           average_position_age_diff
           age
           position
           league
           team
           photo_url
           name_brief
      ])
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
        'photo_url' => @player.photo_url,
        'team' => @player.team,
        'position' => @player.position)
    end
  end
end
