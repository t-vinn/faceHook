ActiveAdmin.register GroupPost do
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
  actions :all, except: [:new, :create]
  show do |f|
    attributes_table do
      row :id
      row :user_id
      row :group_id
      row :content
      row :created_at
      row :updated_at
      panel 'GroupPostFavorites' do
        table_for f.group_post_favorites do
          column(:user_id)
          column(:created_at)
        end
      end
    end
    active_admin_comments
  end
end
