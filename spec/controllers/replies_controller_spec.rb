require 'rails_helper'

RSpec.describe Users::Feeds::RepliesController, type: :controller do
  login_user

  describe 'GET #new' do
    before do
      @feed = create(:feed)
      get :new, params: { feed_id: @feed }
    end

    it 'assigns the requested feed to @feed' do
      expect(assigns(:feed)).to eq @feed
    end

    it 'assigns a new Reply to @reply' do
      expect(assigns(:reply)).to be_a_new(Reply)
    end

    it 'returns 200' do
      expect(response.status).to eq 200
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end

  end

  describe 'POST #create' do
    context 'with valid parameters' do
      before do
        @feed = create(:feed)
      end

      it 'returns 302' do
        post :create, params: { feed_id: @feed, reply: attributes_for(:reply) }
        expect(response.status).to eq 302
      end

      it 'adds a feed to the database' do
        expect{
          post :create, params: { feed_id: @feed, reply: attributes_for(:reply) }
        }.to change(Reply, :count).by(1)
      end

      it 'redirects to root path' do
        post :create, params: { feed_id: @feed, reply: attributes_for(:reply) }
        expect(response).to redirect_to root_path
      end

    end

    context ' with invalid parameters' do

    end
  end

end
