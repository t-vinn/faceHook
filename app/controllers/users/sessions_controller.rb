module Users
  class SessionsController < Devise::SessionsController
    def new
      @public_feeds = Feed.where(privacy: 0)
      super
    end
  end
end
