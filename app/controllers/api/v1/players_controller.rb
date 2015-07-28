class Api::V1::PlayersController < ApplicationController
  caches_action :index, format: :json
  caches_action :show, format: :json

  def index
    players = Rails.cache.fetch('players') { Player.all }
    render json: players, each_serializer: PlayerSerializer
  end

  def show
    player = Player.find_by_public_id params[:id]
    render json: player, serializer: PlayerSerializer
  end
end
