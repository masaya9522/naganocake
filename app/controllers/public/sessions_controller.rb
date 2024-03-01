# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  def after_sign_in_path_for(resource)
    root_path
  end
  
  def after_sign_out_path_for(resource)
    root_path
  end
  
  private
  
  def customer_state
    customer = Customer.find_by(email: params[:customer][:email])
    #customerモデルの保存データの中から、フォームに入力されたemailに紐づく情報を取得する
    return if customer.nil?
    #取得してきたcustomerのデータが存在するか、ないならメソッド終了
    return unless customer.valid_password?(params[:customer][:password])
    #取得したアカウントのパスワードと入力されたパスワードが不一致の場合、このメソッドを終了
    unless customer.is_active == true
      flash[:alert] = "すでに退会しています。"
      redirect_to new_customer_registration_path
    end
    #会員ステータスがtrueでないなら新規登録画面に戻る
  end
    

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
end
