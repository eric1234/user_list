class UsersController < ApplicationController

  # List all users and allow a new user to be created
  def index
    @users = User.find_all_by_active(true)
    @user = User.new params[:user]
  end

  # Create a new user unless the user previously existed (inactive).
  # If previously existed we just re-activate and update properties
  def create
    @user = User.find_or_initialize_by_email params[:user][:email]
    @user.attributes = params[:user]
    @user.password_confirmation = params[:user][:password]
    @user.active = true

    if @user.save
      flash[:notice] = 'User created'
      redirect_to users_url
    else
      @users = User.find_all_by_active(true)
      render :action => 'index'
    end
  end

  # Update the properties of a user
  def update
    @user = User.find params[:id]
    @user.password_confirmation = params[:user][:password] unless
      params[:user][:password].blank?
    if @user.update_attributes params[:user]
      flash[:notice] = 'User updated'
      redirect_to users_url
    else
      @users = [@user] + User.find_all_by_active(true).reject {|u| u.id == @user.id}
      @user = User.new
      render :action => 'index'
    end
  end

  # Deactives a user
  def destroy
    User.find(params[:id]).update_attributes! :active => false
    flash[:notice] = 'User removed'
    redirect_to users_url
  end

end
