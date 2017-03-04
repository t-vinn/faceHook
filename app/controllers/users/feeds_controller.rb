module Users
  class FeedsController < BaseController
    def create
      if Feed.create!(feed_params)
        redirect_to root_path, notice: 'a new feed created'
      else
        redirect_to root_path, notice: 'your message is too short or long!'
      end
    end

    def edit
      @feed = Feed.find(params[:id])
    end

    def update
      @feed = Feed.find(params[:id])
      if @feed.update(feed_params)
        redirect_to root_path, notice: 'the privacy of your feed revised'
      else
        flash.now[:alert] = "We couldn't update the privacy."
        render :edit
      end
    end

    private

      def feed_params
        params.require(:feed).permit(:user_id, :content, :privacy)
      end
  end
end
