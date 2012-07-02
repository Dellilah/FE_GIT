# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def authenticate
    if !current_user
      flash[:notice] = "Musisz być zalogowany!"
      redirect_to new_user_session_path
    end
  end
  
  def admin_required
  	if !current_user
      redirect_to new_user_session_path
	elsif !current_user.admin?
		flash[:notice] = "Przykro nam, nie masz uprawnien"
		redirect_to root_url
	end
  end
  	
  
  def store_location
  	session[:return_to] = request.fullpath
  end
  
  def reminder
    @upcoming_date = DateTime.now + 2.days
    
#    @users = User.all
#    @users.each do |user|
#      @user_events = user.events
#      @user_events.each do |event|
#	
#	if event.start_date <= @upcoming_date && !event.reminded && event.stop_date > Date.today
#	  event.reminded = true
#	  event.save
#	  UserMailer.remind_email(user, event).deliver
#	end
#	
#      end
    #end
    
    @events = Event.all
    @events.each do |event|
      @flag = 0  
      @event_users = event.users
      @event_users.each do |user|
	
	if event.start_date <= @upcoming_date && !event.reminded && event.stop_date > Date.today
	  @flag = 1
	  UserMailer.remind_email(user, event).deliver
	end

      end
      if @flag == 1
	event.reminded = true
	event.save
      end
      
    end
 

  end



end
