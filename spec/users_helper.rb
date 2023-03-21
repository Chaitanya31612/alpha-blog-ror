# frozen_string_literal: true
def sign_in(admin=false, username='chaitanya1', email='test@example.com', password: '123rfd')
  # User.create(username: 'chaitanya1', email: 'test@example.com', password: '123rfd', admin: admin)
  # post login_path, params: {session: {username: 'chaitanya1', email: 'test@example.com', password: '123rfd'}}

  post '/users', params: {user: {username: username, email: email, password: password}}
  user = User.find_by(username: username)
  user.toggle!(:admin) if admin
end

def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

def logout_user
  puts "user = #{current_user.username}"
  delete '/logout' if current_user
  puts "user after delete = #{current_user}"
end