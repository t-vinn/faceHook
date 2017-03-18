require 'rails_helper'

RSpec.describe Users::FeedsController, type: :controller do
  login_user

  describe 'POST #create' do
    context 'with valid parameters' do

      it 'returns 302' do
        post :create, feed: attributes_for(:feed)
        expect(response.status).to eq 302
      end

      it 'adds a feed to the database' do
        expect{
          post :create, feed: attributes_for(:feed)
        }.to change(Feed, :count).by(1)
      end

      it 'redirects to root path' do
        post :create, feed: attributes_for(:feed)
        expect(response).to redirect_to root_path
      end

      it 'sends an email' do
        expect {
          post :create, feed: attributes_for(:feed)
          mail = ActionMailer::Base.deliveries.last
          expect(mail.subject).to eq 'A new feed posted'
        }.to change(ActionMailer::Base.deliveries, :size).by 1
      end
    end

    context 'with invalid parameters' do

      it 'returns 302' do
        post :create, feed: attributes_for(:invalid_feed)
        expect(response.status).to eq 302
      end

      it 'adds a feed to the database' do
        expect{
          post :create, feed: attributes_for(:invalid_feed)
        }.not_to change(Feed, :count)
      end

      it 'redirects to root path' do
        post :create, feed: attributes_for(:invalid_feed)
        expect(response).to redirect_to root_path
      end

    end
  end

  describe 'GET #edit' do
    before do
      @feed = create(:feed)
      get :edit, params: { id: @feed }
    end
    it 'assigns the requested feed to @feed' do
      expect(assigns(:feed)).to eq @feed
    end

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'renders the :edit template' do
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH #update' do
    before :each do
      @feed = create(:feed)
    end
    context 'valid attributes' do

      it "changes @feed's attributes" do
        patch :update, id: @feed,
          feed: attributes_for(:feed,
            privacy: 'share_with_only_me')
        @feed.reload
        expect(@feed.privacy).to eq('share_with_only_me')
      end

      it 'redirects to root path' do
        patch :update, id: @feed, feed: attributes_for(:feed)
        expect(response).to redirect_to root_path
      end
    end
    
  end
end
