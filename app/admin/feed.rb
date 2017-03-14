ActiveAdmin.register Feed do
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
  #
  menu parent: 'Feed'
  actions :all, except: [:new, :create]
  permit_params :content, :privacy
  form feed: 'Edit feed' do |f|
    inputs 'Details' do
      li "Created by #{f.object.user.name}"
      input :content
      input :privacy
      li "Created at #{f.object.created_at}" unless f.object.new_record?
    end
    actions
  end

  show do |f|
    attributes_table do
      row :user_id
      row :content
      row :privacy
      row :created_at
      row :updated_at
      panel 'FeedFavorites' do
        table_for f.feed_favorites do
          column :user_id
        end
      end
      panel 'Replies' do
        table_for f.replies do
          column(:id)
          column(:user_id)
          column(:content)
        end
      end
    end
    active_admin_comments
  end
end
