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

      serializer = PlayerSerializer.new player

      json = serializer.as_json

      expect(json[:player]).to eq(
        id: '123',
        first_name: 'Jimmy',
        last_name: 'Howard',
        age: 31,
        position: 'G',
      )
    end
  end
end
