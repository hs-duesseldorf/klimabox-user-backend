module Backend
  class TopicsController < BaseController
    def index
      @topics = Topic.all
    end

    def new
      @topic = Topic.new
    end

    def create
      @topic = Topic.new(topic_params)
      if @topic.save
        redirect_to backend_topics_path
      else
        flash[:alert] = "Neues Topic konnte nicht angelegt werden."
        render :new
      end
  end

    def edit
      @topic = Topic.find_by(id: params[:id])
    end

    def update
      @topic = Topic.find_by(id: params[:id])

      if @topic.update(topic_params)
        flash[:success] = "Topic wurde bearbeitet."
        redirect_to backend_topics_path
      else
        flash[:alert] = "Topic konnte nicht bearbeitet werden."
        render :edit
      end
    end

    def destroy
      @topic = Topic.find_by(id: params[:id])

      if @topic.destroy
        redirect_to backend_topics_path
      else
        # Flashmessage
      end
    end

    private
    def topic_params
      params.require(:topic).permit(:name, :description)
    end
  end
end