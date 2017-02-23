module Users
  class SessionsController < Devise::SessionsController
    def new
      @public_feeds = Feed.share_with_all
      super
    end
  end
end
