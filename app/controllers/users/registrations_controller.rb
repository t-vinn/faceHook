module Users
  class RegistrationsController < Devise::RegistrationsController
    def sign_up_params
      devise_parameter_sanitizer.permit(
        :sign_up,
        keys: [:email, :name, :password, :password_confirmation, :notification_allowed]
      )
      super
    end

    def account_update_params
      devise_parameter_sanitizer.permit(
        :account_update,
        keys: [:name, :password, :password_confirmation, :current_password,
               :birth_date, :notification_allowed, :picture]
      )
      super
    end
  end
end
