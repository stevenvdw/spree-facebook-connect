class Admin::FacebookConnectsController < Admin::BaseController

  def update
    Spree::Config.set(params[:preferences])
    Facebooker.spree_reload
    respond_to do |format|
      format.html {
        redirect_to admin_facebook_connect_path
      }
    end
  end

end
