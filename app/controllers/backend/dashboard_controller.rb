module Backend
  class DashboardController < BaseController

    def dashboard
      @users = User.all
    end

    def chart
      @data = []
      Topic.all.each do |topic|
        @data << [topic.name, TopicsUser.where(topic_id: topic.id).count ]
      end
    end
  end
end