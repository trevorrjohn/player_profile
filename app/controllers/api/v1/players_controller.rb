module Api
  module V1
    class PlayersController < ApplicationController
      def index
        players_json = Rails.cache.fetch('players_json') do
          render_to_string json: ActiveModelSerializers::SerializableResource.new(
            Player.all, root: :players).as_json
        end
        render json: players_json
      end

      def show
        player = Player.find_by_public_id params[:id]
        render json: ActiveModelSerializers::SerializableResource.new(
          player, root: :player).as_json
      end
    end
  end
end
