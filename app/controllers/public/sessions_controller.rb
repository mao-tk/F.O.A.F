# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end


  def guest_sign_in
    user = User.guest
    folder = Folder.create(user: user, name: "マイリスト")
    sign_in user
    redirect_to root_path
  end

  def guest_sign_out
    user = User.guest
    user.destroy
    redirect_to root_path
  end

  protected

  def user_state
    @user = User.find_by(email: params[:user][:email])
    return if !@user

    if @user.valid_password?(params[:customer][:password]) && @user.is_deleated
      flash[:danger] = "退会済みの為、再度ご登録してご利用ください"
      redirect_to new_user_registration_path
    end
  end

end
