class AccountsController < ApplicationController
  before_filter :authenticate_user!
  layout "accounts"

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update_with_password params[:user]
        sign_in @user, :bypass => true
        format.html { redirect_to edit_account_path }
      else
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end
end
