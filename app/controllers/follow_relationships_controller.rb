class FollowRelationshipsController < ApplicationController
  def index
    @users = User.all
  end
end
