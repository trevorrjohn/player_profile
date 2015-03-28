require 'rails_helper'

describe Api::V1::PlayersController do
  describe "GET 'index'" do
    it 'responds with success' do
      players = FactoryGirl.build_stubbed_list :player, 1
      allow(Player).to receive(:all).and_return(players)

      get :index

      expect(response).to be_success
    end
  end

  describe "GET 'show'" do
    it 'responds with success' do
      player = FactoryGirl.build :player
      allow(Player).to receive(:find_by_public_id).and_return(player)

      get :show, id: player.public_id

      expect(response).to be_success
    end
  end
end
