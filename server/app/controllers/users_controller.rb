class UsersController < ApplicationController

  before_action :user_find, only: [:show, :edit, :destroy, :update]

  def new
    @user = User.new
  end

  def show
    render json: {user: @user}
  end

  def create
    @user = User.new(name: params[:user][:oauth_name], facebook_id: params[:user][:oauth_id])
    p @user
    if @user.save
      render json: { user: @user }, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit
    render json: {user: @user}
  end

  def destroy
    @user.destroy
  end

  def update
    @user.update(name: params[:name], password: params[:password], email: params[:email])
  end

  private

  def user_find
    @user = User.find(params[:id])
  end

end
