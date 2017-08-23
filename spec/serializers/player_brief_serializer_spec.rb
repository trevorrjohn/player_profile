require 'rails_helper'

describe PlayerBriefSerializer do
  describe 'serialization' do
    it 'serializes the player info' do
      player = FactoryGirl.build(:player, :nhl,
                                 public_id: '123',
                                 first_name: 'Jimmy',
                                 last_name: 'Howard',
                                 age: 31,
                                 team: 'DET',
                                 photo_url: 'photo.png',
                                 position: 'G')
      allow(NHL).to receive(:average_age_for_position).and_return(27)

      serializer = PlayerBriefSerializer.new player

      json = serializer.as_json

      expect(json).to eq(
        id: '123',
        first_name: 'Jimmy',
        last_name: 'Howard',
        league: 'NHL',
        team: 'DET',
        photo_url: 'photo.png',
      )
    end

    context 'with no average ages for the position' do
      it 'returns nil for the average_position_age_diff' do
        player = FactoryGirl.build(:player, :nhl,
                                   public_id: '123',
                                   first_name: 'Jimmy',
                                   last_name: 'Howard',
                                   age: nil,
                                   team: 'DET',
                                   photo_url: 'photo.png',
                                   position: 'G')
        allow(NHL).to receive(:average_age_for_position)

        serializer = PlayerBriefSerializer.new player

        json = serializer.as_json

        expect(json).to eq(
          id: '123',
          first_name: 'Jimmy',
          last_name: 'Howard',
          league: 'NHL',
          team: 'DET',
          photo_url: 'photo.png',
        )
      end
    end

    context 'with average ages for the position but no age' do
      it 'returns nil for the average_position_age_diff' do
        player = FactoryGirl.build(:player, :nhl,
                                   public_id: '123',
                                   first_name: 'Jimmy',
                                   last_name: 'Howard',
                                   age: nil,
                                   team: 'DET',
                                   photo_url: 'photo.png',
                                   position: 'G')
        allow(NHL).to receive(:average_age_for_position).and_return(23)

        serializer = PlayerBriefSerializer.new player

        json = serializer.as_json

        expect(json).to eq(
          id: '123',
          first_name: 'Jimmy',
          last_name: 'Howard',
          league: 'NHL',
          team: 'DET',
          photo_url: 'photo.png',
        )
      end
    end
  end
end
