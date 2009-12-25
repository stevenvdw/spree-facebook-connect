# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class FacebookConnectExtension < Spree::Extension
  version "1.0"
  description "Describe your extension here"
  url "http://yourwebsite.com/facebook_connect"

  # Please use facebook_connect/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end

  def activate

    # Add your extension tab to the admin.
    # Requires that you have defined an admin controller:
    # app/controllers/admin/yourextension_controller
    # and that you mapped your admin in config/routes

    #Admin::BaseController.class_eval do
    #  before_filter :add_yourextension_tab
    #
    #  def add_yourextension_tab
    #    # add_extension_admin_tab takes an array containing the same arguments expected
    #    # by the tab helper method:
    #    #   [ :extension_name, { :label => "Your Extension", :route => "/some/non/standard/route" } ]
    #    add_extension_admin_tab [ :yourextension ]
    #  end
    #end

    UserSession.facebook_uid_field = :facebook_id
    UserSession.facebook_session_key_field = :session_key

    # make your helper avaliable in all views
    Spree::BaseController.class_eval do
      # helper YourHelper
    end

    ApplicationHelper.class_eval do
      def user_name_with_fb_name(user)
        if user.facebook_id.nil?
          user_name_without_fb_name(user)
        else
          fb_name(user.facebook_id, :useyou => false, :linked => false)
        end
      end
      alias_method_chain :user_name, :fb_name
    end
  end
end
