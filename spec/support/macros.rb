#spec/support/macros.rb
def set_current_user
  andrew = Fabricate(:user)
  session[:user_id] = andrew.id
end

def curent_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end
