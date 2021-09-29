module Api
  module V1
    class TopicsController < ::Api::V1::BaseController
      before_action do
        authenticate_cookie
      end

      def topics
        @topics = Topic.all

        if @topics.any?
          render json: @topics, each_serializer: TopicSerializer, status: 200
        else
          render json: { message: "No Topics found" }, status: 422
        end
      end

      def add_topic
        @topic = Topic.find_by(name: topics_params[:name])
        current_user.topics << @topic
        if current_user.save
          render json: @topic, serializer: TopicSerializer , status: 200
        else
          render json: { errors: @topic.errors }, status: 422
        end
      end

      def remove_topic
        @topic = Topic.find_by(name: topics_params[:name])
        current_user.topics.delete(@topic.id)
        if current_user.save
          render json: {message: "Eintrag erfolgreich gelöscht"}, status: 200
        else
          render json: { error: "Da ist etwas schief gelaufen. Bitte nochmal probieren" }, status: 422
        end
      end

      private

      def topics_params
        params.require(:topic).permit(:name)
      end
    end
  end
end