class Api::V1::PlayersController < ApplicationController
  caches_action :index, format: :json
  caches_action :show, format: :json

  def index
    players = Player.find_each
    render json: players, each_serializer: PlayerSerializer, root: 'players'
  end

  def show
    player = Player.find_by_public_id params[:id]
    render json: player, serializer: PlayerSerializer
  end
end
