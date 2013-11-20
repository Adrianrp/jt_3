class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # This include gives access to authentication functions across all the controllers
  # Is a module, and  by default all its functions are available in all the views.
  # but not in the controllers, that is why we have to declare it explicitly
  include SessionsHelper
end
