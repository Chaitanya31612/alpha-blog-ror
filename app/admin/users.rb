ActiveAdmin.register User do
  permit_params :username, :email, :password, :admin, article_ids: []

  index do
    selectable_column
    id_column
    column :username
    column :email
    column 'Password digest' do |user|
      user.password_digest.truncate(20)
    end
    column :admin
    # column 'Article Ids' do |user|
    #   user.article_ids.each do |id|
    #     span link_to id, article_path(id)
    #   end
    # end
    column :article_ids
    column :created_at
    column :updated_at
    actions
  end

  form title: "New user" do |f|
    f.inputs 'new user' do
      f.input :username
      f.input :email
      f.input :password
      f.input :admin
    end
    f.actions
  end


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :username, :email, :password_digest, :admin, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:username, :email, :password_digest, :admin, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
