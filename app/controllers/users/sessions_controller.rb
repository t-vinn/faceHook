module Users
  class SessionsController < Devise::SessionsController
    def new
      public_feeds = Feed.share_with_all.includes(:user, :feed_pictures, [replies: :user]) \
                         .order('created_at DESC')
      @public_feeds = Kaminari.paginate_array(public_feeds).page(params[:page])
      super
    end
  end
end
