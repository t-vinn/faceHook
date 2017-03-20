require 'rails_helper'

RSpec.describe Users::FeedsController, type: :controller do
  login_user

  describe 'POST #create' do
    include ActiveJob::TestHelper
    let(:feed) { build(:feed, :with_user) }

    context 'with valid parameters' do
      let(:feed_params) { { content: feed.content, user_id: feed.user_id, privacy: feed.privacy } }

      subject { post :create, params: { feed: feed_params } }

      it { is_expected.to have_http_status(302) }
      it { expect{ subject }.to change(Feed, :count).by(1) }
      it { is_expected.to redirect_to root_path }
      it {
        expect(UserMailer).to receive(:feed_creation).and_return( double('UserMailer', deliver_later: true))
        expect{ subject }      
        expect {
          perform_enqueued_jobs do
            UserMailer.feed_creation(feed).deliver_later
          end
        }.to change{ ActionMailer::Base.deliveries.size }.by(1)
      }

      it {
        expect(subject)
        expect {
          perform_enqueued_jobs do
            UserMailer.feed_creation(feed).deliver_later
          end
        }.to change{ ActionMailer::Base.deliveries.size }.by(1)
      }
    end

    context 'with invalid parameters' do
      let(:invalid_feed_params) { { content: nil, user_id: feed.user_id, privacy: feed.privacy } }
      subject { post :create, params: { feed: invalid_feed_params } }

      it { is_expected.to have_http_status(302) }
      it { expect { subject }.not_to change(Feed, :count) }
      it { is_expected.to redirect_to root_path } 
    end
  end

  describe 'GET #edit' do
    let(:feed) { create(:feed, :with_user) }
    subject! { get :edit, params: { id: feed } }
    
    it { expect(assigns(:feed)).to eq feed }
    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template :edit }
  end

  describe 'PATCH #update' do
    let(:feed) { create(:feed, :with_user) }
    let(:changed_feed_params) { { content: feed.content, user_id: feed.user_id, privacy: 'share_with_only_me' } }
    subject { patch :update, params: { id: feed, feed: changed_feed_params } }

    context 'valid attributes' do
      it "changes @feed's attributes" do
        subject
        feed.reload
        expect(feed.privacy).to eq('share_with_only_me')
      end

      it { is_expected.to redirect_to root_path }
    end
  end
end
