class ApplicationController < ActionController::Base
  include Pundit
  include SessionsHelper
end
