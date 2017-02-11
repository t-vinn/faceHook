module Users
  class SessionsController < Devise::SessionsController
    def new
      @public_feeds = Feed.public_feed
      super
    end
  end
end
