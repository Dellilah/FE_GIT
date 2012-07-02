class VisibilitiesController < ApplicationController
  before_filter :authenticate, :current_user, :reminder
	
  def changevisibility_form
  	@user = @current_user
  	@visibility = Visibility.find(:first, :conditions => ["user_id = ?", @user.id])
  	if !@visibility
  		@visibility = Visibility.new(:email => true, :name => true, :surname => true, :avatar_url => true, :events => true, :user_id => @user.id)
  		@visibility.save
  	end
  end

  def change_visibility
  	@user = User.find(params[:user_id])
  	@visibility = Visibility.find(params[:visibility_id])
    respond_to do |format|
      if @visibility.update_attributes(:name => params[:name], :surname => params[:surname], :email => params[:email], :surname => params[:surname], :avatar_url => params[:avatar_url], :events => params[:events])
        format.html { redirect_to root_url, notice: 'Zaktualizowano' }
        format.json { head :ok }
      else
        format.html { render action: "changevisibility_form" }
      end
    end
  	
  end

end
