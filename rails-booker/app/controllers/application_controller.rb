class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception

  #Before filter to change language link
    before_filter :set_locale

  #To change Language Link to
def set_locale
  I18n.locale = params[:locale] if params[:locale].present?
end

#To not break url with language
def default_url_options(options = {})
   {locale: I18n.locale}
 end



  end
