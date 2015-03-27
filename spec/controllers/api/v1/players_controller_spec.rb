require 'rails_helper'

describe Api::V1::PlayersController do
  describe "GET 'index'" do
    context 'with no url params' do
      it 'responds with success' do
        players = FactoryGirl.build_stubbed_list :player, 1
        allow(Player).to receive(:all).and_return(players)

        get :index

        expect(response).to be_success
      end
    end
  end
end
