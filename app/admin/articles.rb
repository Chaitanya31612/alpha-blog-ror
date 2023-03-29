ActiveAdmin.register Article do
  permit_params :title, :description, :featured, :user_id

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :featured
    # column 'Category Ids' do |user|
    #   user.category_ids.map { |id| span link_to id, category_path(id)}.join(", ").html_safe
    # end
    column :category_ids
    column :user
    column :user_id
    column :created_at
    column :updated_at
    actions
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :description, :user_id, :featured
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :description, :user_id, :featured]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
