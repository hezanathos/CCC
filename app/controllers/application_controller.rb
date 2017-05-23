# frozen_string_literal: true

# Application controller
#
# @author Alex Lecoq
# @since 0.0.0
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
