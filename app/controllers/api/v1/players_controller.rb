class Api::V1::PlayersController < ApplicationController
  def index
    players = Player.all
    render json: players, each_serializer: PlayerSerializer
  end

  def show
    player = Player.find_by_public_id params[:id]
    render json: player, serializer: PlayerSerializer
  end
end
