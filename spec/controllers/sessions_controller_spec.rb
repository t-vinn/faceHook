require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'GET #new' do
    it 'returns 200' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      get :new
      expect(response.status).to eq 200
    end

    it 'assigns the requested feeds to @public_feeds' do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      @feeds = create_list(:feed, 2)
      get :new
      expect(assigns(:public_feeds)).to eq @feeds
    end
  end
end
