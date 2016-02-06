class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  
  def find_user_name
     if user_signed_in?
        return user.user_name
     end
  end
  
end


