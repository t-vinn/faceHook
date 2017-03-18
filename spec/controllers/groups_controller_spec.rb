require 'rails_helper'

RSpec.describe Users::GroupsController, type: :controller do
  login_user

  describe 'GET #index' do
    it 'assigns the requested group to @group' do
      get :index
      expect(assigns(:group)).to be_a_new(Group)
    end

    it 'assigns the requested groups to @groups' do
      groups = user.groups.create_list(:group, 2)
      get :index
      expect(assigns(:groups)).to match_array(groups)
    end

    it 'renders the :index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'returns 200' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET #show' do

    it 'assigns the requested group to @group' do
      @group = create(:group)
      get :show, params: { id: @group }
      expect(assigns(:group)).to eq @group
    end
    
    it 'assigns the requested group_posts to @group_posts' do
      @group = create(:group)
      created_posts = create_list(:group_post, 5)
      get :show, params: { id: @group }
      expect(assigns(:group_posts)).to match_array(created_posts)
    end
    
    it 'assigns the requested group_post to @group_post' do
      @group = create(:group)
      get :show, params: { id: @group }
      expect(assigns(:group_post)).to be_a_new(GroupPost)
    end
    
    it 'assigns the requested group_post_favorites to @group_post_favorites_index_by_group_post_id' do
      @group = create(:group)
      group_post_favorites = create_list(:group_post_favorite, 5)
      get :show, params: { id: @group }
      expect(assigns(:group_post_favorites_index_by_group_post_id)).to match_array(group_post_favorites)
    end
    
    it 'renders the :show template' do
      @group = create(:group)
      get :show, params: { id: @group }
      expect(response).to render_template :show
    end

    it 'returns 200' do
      @group = create(:group)
      get :show, params: { id: @group }
      expect(response.status).to eq 200
    end

  end
end
