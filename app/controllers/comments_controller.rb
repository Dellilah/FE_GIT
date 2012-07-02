class CommentsController < ApplicationController
  before_filter :current_user, :store_location
  before_filter :authenticate, :reminder


  def addcomment_form
  	
   	@event = Event.find(params[:id])
   	@comment = Comment.new
  	
  	respond_to do |format|
      format.html # addcomment_form.html.erb
      format.json {head :ok}
    end
  end
   
  def addcomment
    @comment = Comment.new(:content => params[:content], :user_id => params[:user_id], :event_id => params[:event_id])
    @event = Event.find(params[:event_id])

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @event, notice: 'Komentarz dodany' }
        format.json { render json: @comment, status: :created, location: @comment }
      else
        format.html { render action: "addcomment_form" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
    @event = @comment.event
    @author = @comment.user
    
    
    if @current_user != @author && !@current_user.admin
      respond_to do |format|
      format.html { redirect_to @event, notice: 'Brak uprawnien' }
      format.json { render json: @comment, status: :created, location: @comment }
      end
    end
  end
  
  def update
    @comment = Comment.find(params[:id])
    @author = @comment.user
    @comment.content = params[:content]
    @time = Time.now.strftime("%d-%m-%Y %H:%M ")
    @comment.difference = "Ostatnia edycja: "
    @comment.difference << @time
    if @current_user.admin && !@author.admin
      @comment.difference << ', Administrator'
    end
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.event, notice: 'Komentarz zmieniony' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def remove
    @comment = Comment.find(params[:id])
    @event = @comment.event
    @author = @comment.user
    
    if @current_user == @author
      @comment.content = "Komentarz usuniety przez uzytkownika"
      @comment.save
      
    elsif @current_user.admin

      @comment.content = "Komentarz usuniety przez administratora"
      @comment.save
    else
      
      flash[:notice] = "Brak prawnien"
      
    end
    
    redirect_to @event

  end

end
