# encoding: utf-8
class UsersController < ApplicationController
  before_filter :store_location, :current_user,:reminder
  before_filter :authenticate, :only => [:show]
  

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @visibility = Visibility.new(:email => true, :name => true, :surname => true, :avatar_url => true, :events => true, :user_id => @user.id)
    if @user.save
      @visibility.save
      UserMailer.welcome_email(@user).deliver
      flash[:notice]= "Rejestracja powiodła się"
      redirect_to root_url
    else
      flash[:notice] = "Rejestracja nie powiodła się"
      render :action => 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Dane zmienione "
      redirect_to root_url
    else
      flash[:notice] = "Edycja nie powiodła się"
      render :action => 'edit'
    end
  end 

  def show
    @users = User.all
  end
  
  def show_profile
  	if !Visibility.find(:first, :conditions => ["user_id = 0"])
	  @visibility = Visibility.new(:email => true, :name => true, :surname => true, :avatar_url => true, :events => true, :user_id => '0')
	  @visibility.save
  	end
  	if params[:id]
  		@user = User.find(params[:id])
  		if @user == current_user
  		   @visibility = Visibility.find(:first, :conditions => ["user_id = 0"])
  		else
  		    @visibility = Visibility.find(:first, :conditions => ["user_id = ?", @user.id])
  		    if !@visibility
		      @visibility = Visibility.find(:first, :conditions => ["user_id = 0"])
  		    end
  		end
  	else
  		@user = current_user
  		@visibility = Visibility.find(:first, :conditions => ["user_id = 0"])
  	end
  	
  end	
  

end
