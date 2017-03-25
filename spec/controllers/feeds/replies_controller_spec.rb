require 'rails_helper'

RSpec.describe Users::Feeds::RepliesController, type: :controller do
  login_user

  describe 'GET #new' do
    let(:feed) { create(:feed, :with_user) }

    subject { get :new, params: { feed_id: feed } }

    it 'assigns the requested feed to @feed' do
      subject
      expect(assigns(:feed)).to eq feed
    end

    it 'assigns a new Reply to @reply' do
      subject
      expect(assigns(:reply)).to be_a_new(Reply)
    end

    it 'returns 200' do
      is_expected.to have_http_status 200
    end

    it 'renders the new template' do
      is_expected.to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:feed) { create(:feed, :with_user) }

      let(:reply) { build(:reply) }

      let(:reply_params) { { content: reply.content, user_id: reply.user_id, feed_id: reply.feed_id } }

      subject { post :create, params: { feed_id: feed, reply: reply_params } }

      it 'returns 302' do
        is_expected.to have_http_status 302
      end

      it 'adds a feed to the database' do
        expect { subject }.to change(Reply, :count).by(1)
      end

      it 'redirects to root path' do
        is_expected.to redirect_to root_path
      end
    end

    context ' with invalid parameters' do
    end
  end
end
