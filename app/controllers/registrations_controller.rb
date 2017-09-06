class RegistrationsController < Devise::RegistrationsController

  def after_sign_up_path_for(resource)
    authenticated_root_path(resource)
  end

end
