require 'rails_helper'

RSpec.describe Users::GroupsController, type: :controller do
  login_user

  describe 'GET #index' do
    it 'assigns the requested group to @group' do
      get :index
      expect(assigns(:group)).to be_a_new @group
    end

    it 'assigns the requested groups to @groups' do
      school = create(:group) 
      office = create(:group)
      get :index
      expect(assigns(:groups)).to match_array([school, office])
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
end
