class Api::V1::PlayersController < ApplicationController
  def index
    players_json = Rails.cache.fetch('players_json') do
      ActiveModel::ArraySerializer.new(Player.find_each, root: 'players', each_serializer: PlayerSerializer).to_json
    end
    render json: players_json
  end

  def show
    player = Player.find_by_public_id params[:id]
    render json: player, serializer: PlayerSerializer
  end
end
