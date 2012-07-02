# encoding: utf-8
class TagsController < ApplicationController
  before_filter :current_user, :store_location, :reminder
  before_filter :authenticate, :only => [:new, :edit, :update, :create, :destroy, :addtags_form, :addtags]
  before_filter :admin_required, :only => [:edit, :update, :destroy ]
  # GET /tags
  # GET /tags.json
  def index
    @tags = Tag.order('name')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tags }
    end
  end

  # GET /tags/1
  # GET /tags/1.json
  def show
    @tag = Tag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/new
  # GET /tags/new.json
  def new
    @tag = Tag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tag }
    end
  end

  # GET /tags/1/edit
  def edit
    @tag = Tag.find(params[:id])
  end

  # POST /tags
  # POST /tags.json
  def create
    @tag = Tag.new(params[:tag])

    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: 'Tag dodany do bazy tagów' }
        format.json { render json: @tag, status: :created, location: @tag }
      else
        format.html { render action: "new" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tags/1
  # PUT /tags/1.json
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: 'Tag zaktualizowany' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @tag = Tag.find(params[:id])
    @tag.destroy

    respond_to do |format|
      format.html { redirect_to tags_url }
      format.json { head :ok }
    end
  end
    
  def addtags_form
  	@event = Event.find(params[:id])
   	  	
  	respond_to do |format|
      format.html # addtags_form.html.erb
      format.json {head :ok}
    end
  end
  
  def addtags
  	
  	@tags = params[:names].split
  	@event = Event.find(params[:event_id])
  	
    @tags.each do |tag|
    	if Tag.where(:name => tag).count == 0
    		new_tag = Tag.new(:name => tag)
    		new_tag.save
    	else
    		new_tag  = Tag.where(:name => tag)
    	end
    	@event.tags << new_tag
    end
    flash[:notice] = "Tagi dodane"
    redirect_to @event
    
  end
  
end
