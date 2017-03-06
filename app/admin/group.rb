ActiveAdmin.register Group do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  menu parent: 'Group'
  actions :all, except: [:new, :create, :edit, :update]
  show do |f|
    attributes_table do
      row :name
      row :created_at
      row :updated_at
      row :owner_user
      panel 'Members' do
        table_for f.groups_users do
          column(:user_id)
        end
      end
      panel 'Posts' do
        table_for f.group_posts do
          column(:id)
          column(:user_id)
          column(:content)
          column(:created_at)
        end
      end
    end
    active_admin_comments
  end
end
