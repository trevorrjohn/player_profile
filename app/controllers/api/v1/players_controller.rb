module Api
  module V1
    class PlayersController < ApplicationController
    rescue_from ActionController::ParameterMissing, with: :render_invalid_param
      def index
        players_json = Rails.cache.fetch("v1_#{type_param.downcase}_players_json") do
          players = Player.where('lower(type) = ?', type_param.downcase)
          render_to_string json: ActiveModelSerializers::SerializableResource.new(
            players, root: :players, each_serializer: PlayerBriefSerializer).as_json
        end
        render json: players_json
      end

      def show
        player = Player.find_by_public_id params[:id]
        render json: ActiveModelSerializers::SerializableResource.new(
          player, root: :player).as_json
      end

      private

      def render_invalid_param
        render json: { error: 'Invalid league parameter' }, status: 422
      end

      def type_param
        params.require(:league)
      end
    end
  end
end
