# encoding: utf-8
class UserSessionsController < ApplicationController
  before_filter :reminder
  
  def new
    @user_session= UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Zalogowano"
      redirect_to session[:return_to]
    else
      flash[:notice] = "Logowanie nie powiodło się"
      render :action => 'new'
    end
  end

  def destroy
    if @user_session = UserSession.find
      @user_session.destroy
      flash[:notice] = "Wylogowano"
    end
      redirect_to root_url
  end

end
