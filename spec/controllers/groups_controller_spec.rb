require 'rails_helper'

RSpec.describe Users::GroupsController, type: :controller do
  login_user
  describe 'GET #index' do
    let(:groups) { create_list(:group, 2, owner_user_id: controller.current_user.id) }
    subject { get :index }
    it 'assigns the requested group to @group' do
      subject
      expect(assigns(:group)).to be_a_new(Group)
    end

    it 'assigns the requested groups to @groups' do
      create(:groups_user, group: groups[0], user: controller.current_user)
      subject
      expect(assigns(:groups)).to match_array([groups[0]])
    end

    it 'renders the :index template' do
      is_expected.to render_template :index
    end

    it 'returns 200' do
      is_expected.to have_http_status 200
    end
  end

  describe 'GET #show' do
    let(:group) { create(:group) }
    let!(:group_post) { create(:group_post, group: group) }
    let!(:group_post_favorite) { create(:group_post_favorite, user: controller.current_user, group_post: group_post) }
    subject { get :show, params: { id: group } }

    it 'assigns the requested group to @group' do
      subject
      expect(assigns(:group)).to eq group
    end

    it 'assigns the requested group_posts to @group_posts' do
      subject
      expect(assigns(:group_posts)).to match_array([group_post])
    end

    it 'assigns the requested group_post to @group_post' do
      subject
      expect(assigns(:group_post)).to be_a_new(GroupPost)
    end

    it 'assigns the requested group_post_favorites to @group_post_favorites_index_by_group_post_id' do
      subject
      expect(assigns(:group_post_favorites_index_by_group_post_id)).to match_array([[group_post_favorite.id, group_post_favorite]])
    end

    it 'renders the :show template' do
      is_expected.to render_template :show
    end

    it 'returns 200' do
      is_expected.to have_http_status 200
    end
  end
end
