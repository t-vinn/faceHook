module Users
  class SessionsController < Devise::SessionsController
    def new
      @public_feeds = Feed.share_with_all.includes(:user, [replies: :user]).order(created_at: :desc).page(params[:page])
      super
    end
  end
end
