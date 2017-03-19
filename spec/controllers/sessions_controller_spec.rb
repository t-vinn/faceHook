require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'GET #new' do
    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
    end

    it 'returns 200' do
      get :new
      expect(response.status).to eq 200
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end

    it 'assigns the requested feeds to @public_feeds' do
      @feeds = create_list(:feed, 2)
      get :new
      expect(assigns(:public_feeds)).to eq @feeds
    end
  end
end
