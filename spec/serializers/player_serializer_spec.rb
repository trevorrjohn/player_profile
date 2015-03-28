require 'rails_helper'

describe PlayerSerializer do
  describe 'serialization' do
    it 'serializes the player info' do
      player = FactoryGirl.build(:player, :nhl,
                                 public_id: '123',
                                 first_name: 'Jimmy',
                                 last_name: 'Howard',
                                 age: 31,
                                 position: 'G')
      allow(NHL).to receive(:average_age_for_position).and_return(27)

      serializer = PlayerSerializer.new player

      json = serializer.as_json

      expect(json[:player]).to eq(
        id: '123',
        first_name: 'Jimmy',
        last_name: 'Howard',
        age: 31,
        average_position_age_diff: 4,
        position: 'G',
      )
    end

    context 'with no average ages for the position' do
      it 'returns nil for the average_position_age_diff' do
        player = FactoryGirl.build(:player, :nhl,
                                   public_id: '123',
                                   first_name: 'Jimmy',
                                   last_name: 'Howard',
                                   age: nil,
                                   position: 'G')
        allow(NHL).to receive(:average_age_for_position)

        serializer = PlayerSerializer.new player

        json = serializer.as_json

        expect(json[:player]).to eq(
          id: '123',
          first_name: 'Jimmy',
          last_name: 'Howard',
          age: nil,
          average_position_age_diff: nil,
          position: 'G',
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
                                   position: 'G')
        allow(NHL).to receive(:average_age_for_position).and_return(23)

        serializer = PlayerSerializer.new player

        json = serializer.as_json

        expect(json[:player]).to eq(
          id: '123',
          first_name: 'Jimmy',
          last_name: 'Howard',
          age: nil,
          average_position_age_diff: nil,
          position: 'G',
        )
      end
    end
  end
end
