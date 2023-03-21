require 'users_helper'

def new_article(user=nil, title="New title", description: "New description Content")
  if user
    sign_in(user.username, user.email, user.password)
  else
    sign_in
  end

  post '/articles', params: {article: {title: title, description: description}}
  Article.find_by(title: title)

  # logout_user
end

