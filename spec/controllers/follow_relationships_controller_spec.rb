require 'rails_helper'

RSpec.describe Users::FollowRelationshipsController, type: :controller do

  describe 'POST #create' do
    context 'with valid parameters' do
      login_user

      it 'saves the new follow_relationship' do
        expect{
          post :create, params: { follower_user_id: subject.current_user.id, followee_user_id: subject.current_user.id + 1 }
        }.to change(FollowRelationship, :count).by(1)
      end

      it 'redirects to root path' do
        post :create, params: { follow_relationship: attributes_for(:follow_relationship) }
        expect(response).to redirect_to root_path
      end

      it 'returns 302' do
        post :create, params: { follow_relationship: attributes_for(:follow_relationship) }
        expect(response.status).to eq 302
      end
    end
  end

  describe 'DELETE #destroy' do
    login_user
    before do
      @follow_relationship = create(:follow_relationship)
    end
    it 'deletes the follow_relationship' do
      expect{
        delete :destroy, params: { id: @follow_relationship }
      }.to change(FollowRelationship, :count).by(-1)
    end

    it 'redirects to root_path' do
      delete :destroy, params: { id: @follow_relationship }
      expect(response).to redirect_to root_path
    end
  end
end
