class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find params[:id]
  end

  def edit
    @user = User.find params[:id]
    check_if_current_user_is_editing_your_own_account
  end

  def update
    @user = User.find params[:id]

    check_if_current_user_is_editing_your_own_account

    if @user.update user_params
      flash[:notice] = 'Usuário atualizado com sucesso!'
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find params[:id]
    check_if_current_user_is_editing_your_own_account
    @user.destroy
    redirect_to root_path, notice: 'Usuário destruído com sucesso!'
  end

  private

  def check_if_current_user_is_editing_your_own_account
    if @user != current_user
      flash[:warning] = 'Você só pode alterar a sua própria conta de Usuário!'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit :email
  end
end
