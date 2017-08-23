require 'rails_helper'
require 'rspec_api_documentation/dsl'

resource 'GET Player#index' do
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
      expect(player.keys).to match_array(
        %w[ 
          id
          first_name
          last_name
          league
          team
          photo_url
        ])
    end

    example 'Get NHL players' do
      do_request league: 'NHL'

      player = json_response['players'][0]
      expect(status).to eq 200
      expect(json_response['players'].size).to eq 3
      expect(player.keys).to match_array(
        %w[ 
          id
          first_name
          last_name
          league
          team
          photo_url
        ])
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
          league
          team
          photo_url
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
          league
          team
          photo_url
        ])
    end
  end
end
