require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  describe 'GET #new' do
    before do
      request.env['devise.mapping'] = Devise.mappings[:user]
    end
    subject { get :new }

    it 'returns 200' do
      is_expected.to have_http_status 200
    end

    it 'renders the new template' do
      is_expected.to render_template :new
    end

    it 'assigns the requested feeds to @public_feeds' do
      feeds = create_list(:feed, 2, :with_user)
      subject
      expect(assigns(:public_feeds)).to eq feeds
    end
  end
end
