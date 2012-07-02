# encoding: utf-8
class EventsController < ApplicationController

  before_filter :admin_required, :only => [:edit, :update, :destroy, :admin_confirmation, :admin_rollback_confirmation]
  before_filter :find_categories, :only => [:new, :edit, :update, :create]
  before_filter :current_user, :store_location, :reminder	
  before_filter :authenticate, :only => [:new, :edit, :update, :create, :destroy, :subscribe, :recommended_events]
  before_filter :sort_by_popularity, :only => [:index]
  
  
  # GET /events
  # GET /events.json
  def index
    @json = Event.all.to_gmaps4rails

    @events = Event.all
    
    if params[:order]
    	if params[:order] == "the_latest"
    		@order = "Ostatnio dodane"
    		@events = Event.order('created_at DESC').find(:all, :conditions => ["stop_date >= date('now')"])
    	elsif params[:order] == "upcoming"
    		@order = "Nadchodzace"
    		@events = Event.order('start_date ASC').find(:all, :conditions => ["stop_date >= date('now')"])
    	elsif params[:order] == "popular"
    		@events = @events_counts
    		@order = "Najpopularniejsze"
    	elsif params[:order] == "all"
    		@events = Event.order('stop_date DESC')
    		@order = "Wszystkie zarejestrowane wydarzenia"
    	elsif params[:order] == "finished"
    		@events = Event.order('stop_date DESC').find(:all, :conditions => ["stop_date < date('now')"])
    		@order = "Ostatnio zakończone"
    	end
    else
    	@order = "Ostatnio dodane"
    	@events = Event.order('created_at DESC').find(:all, :conditions => ["stop_date >= date('now')"])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
	@users = User.all
  	@event = Event.new(params[:event])
    @tags = params[:tags][:tags]
    @tags=@tags.split
    
    @tags.each do |tag|
    	new_tag = Tag.new(:name => tag)
    	new_tag.save
    	@event.tags << new_tag
    end
    
    if @current_user.admin
    	@event.confirmation = true
    	@event.save
    end

    respond_to do |format|
      if @event.save
      	@users.each do |user|
      		if user.admin && !@current_user.admin
      			UserMailer.event_to_confirm(user, @event).deliver
  			else
      			if user.id == @current_user.id
	      			UserMailer.your_new_event(user, @event).deliver
	  			else
	  				UserMailer.new_event(user, @event).deliver
  				end
  			end
  		end
        format.html { redirect_to @event, notice: 'Wydarzenie dodane do bazy danych' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end


  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Wydarzenie zaktualizowano' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :ok }
    end
  end
  
  # GET /events/1/subscribe
  def subscribe
  	@event = Event.find(params[:id])
	
  	if @event.users.where(:id => @current_user.id).count == 1
		flash[:notice] = "Jestes juz zapisany do wydarzenia!"
	elsif @event.users << User.find(@current_user.id)
  		flash[:notice] = "Zostales zapisany do wydarzenia!"
  	end
  	
    redirect_to :action => "show", :id => params[:id]
  end
  
  # GET /events/1/unsubscribe
  def unsubscribe
  	@event = Event.find(params[:id])
  	@user = User.find(@current_user.id)
  	if @event.users.delete(@user)
  		flash[:notice] = "Zostales wypisany z wydarzenia!"
  	end
    redirect_to :action => "show", :id => params[:id]
  end
  	  
  def find_categories
    @categories=Category.find(:all).map do |category|
      [category.name, category.id]
    end
  end
	
  def search
  	@keys_string = params[:keys]
  	@events = Event.all
  	@tags = Tag.all
  	@categories = Category.all
  	
  	@events_by_category = Array.new
  	@events_by_tag = Array.new
  	@events_by_name = Array.new
  	@events_by_description = Array.new
  	
  	@keys = @keys_string.split
  	@keys.each do |key|
	
  						### POJEDYCZNE SLOWO KLUCZOWE 
  				
  				# wyszukiwanie po nazwie
  			
  		@events.each do |event|
		    	if event.name.include?(key) || event.name.include?(key.capitalize) || event.name.include?(key.downcase)
			  @events_by_name << event
  			end
  			#@words_in_name = event.name.split
  			#@words_in_name.each do |word|
  			#	if word == key || word == key.capitalize || word == key.downcase 
  			#		if !@events_by_name.include?(event)
  			#			@events_by_name << event
  			#		end
  			#	end
  			#end
  		end
  				
  	  			# wyszukiwanie wydarzen po tagach
  	  		@key1 = "%" + key + "%"
  	  		@key2 = "%" + key.capitalize + "%"
  	  		@key3 = "%" + key.downcase + "%"
  		@tags_key = Tag.find(:all, :conditions => ["name LIKE ? OR name LIKE ? OR name LIKE ? ", @key1, @key2, @key3])
  		#@tags_key = Tag.where(:name => key)
  		@tags_key.each do |tag|
  			@events_this_key = tag.events.all
  		
  			@events_this_key.each do |event|
	  		  	if !@events_by_tag.include?(event)
  					@events_by_tag << event
  				end
	  		end
  		end  		
  				#wyszukiwanie wydarzen po kategorii
  		
  		@categories_key = Category.find(:all, :conditions => ["name LIKE ? OR name LIKE ? OR name LIKE ? ", @key1, @key2, @key3])
  		#@categories_key = Category.where(:name => key)
  		@categories_key.each do |category|
  			@events_this_key = category.events.all
  			
  			@events_this_key.each do |event|
  				if !@events_by_category.include?(event)
  					@events_by_category << event
  				end
	  		end
  		end
  		
  				# wyszukiwanie po opisie
  			
  		@events.each do |event|
  			#@words_in_description = event.description.split
  			if event.description.include?(key) || event.description.include?(key.capitalize) || event.description.include?(key.downcase)
			  @events_by_description << event
  			end
  			#@words_in_description.each do |word|
  			#	if word == key || word == key.capitalize || word == key.downcase 
  			#		if !@events_by_description.include?(event)
  			#			@events_by_description << event
  			#		end
  			#	end
  			#end
  		end
  		
  	end
  end
  
  def sort_by_popularity
  	
  	@events= Event.find(:all, :conditions => ["stop_date >= date('now')"])
  	@events_by_popularity = Array.new
  	@id_count = Hash.new
  	@events_counts = Array.new
  	
  	@events.each do |event|
  		@id_count[event.id] = event.users.count
  		
  	end
  	@id_count_sorted = @id_count.sort{|a,b| b[1] <=> a[1]} 
  	@id_count_sorted.each do |id|
  		@events_counts << Event.find(id[0])
  	end
  	
  		
  end	
  
  def admin_confirmation
  	@event = Event.find(params[:id])
  	if @event.confirmation
  		flash[:notice] = "Wydarzenie jest jest już potwierdzone"
		redirect_to :action => "show"
	else
	  	@event.confirmation = true
	  	respond_to do |format|
	      if @event.save
	        format.html { redirect_to @event, notice: 'Wydarzenie potwierdzono' }
	        format.json { head :ok }
	      else
	        format.html { redirect_to @event, notice: 'Wydarzenie nie zostało potwierdzone' }
	        format.json { render json: @event.errors, status: :unprocessable_entity }
	      end  	
		end  	
	end
  end
  
  def admin_rollback_confirmation
  	@event = Event.find(params[:id])
  	if @event.confirmation
	  		
	  	@event.confirmation = false
	  	respond_to do |format|
	      if @event.save
	        format.html { redirect_to @event, notice: 'Cofnięto potwierdzenie wydarzenia' }
	        format.json { head :ok }
	      else
	        format.html { redirect_to @event, notice: 'Nie udało się cofnąć potwierdzenia' }
	        format.json { render json: @event.errors, status: :unprocessable_entity }
	      end  	
		end 
	else
		flash[:notice] = "Wydarzenie jest nie potwierdzone"
		redirect_to :action => "show"
	end
  end
  
  def recommended_events
  	
  	@recommended_by_category_id = Array.new
  	@recommended_by_tags_id = Array.new
  	@events_all = Event.all
  	@user_events = @current_user.events
	@date = Date.today
	#### Wyszukiwanie ze wzgledu na KATEGORIE cieszace sie zainteresowaniem ####
  	
  	@tab_recommended_category_count_similar = Array.new
  	@user_events.each do |user_event|
  		@events_all = Event.all
  		@date = Date.today
  		@flag = 0	
  		@recommended_by_category_name = Array.new
  		@category = user_event.category
  		@tab_recommended_category_count_similar.each do |tab|
  			if tab[0] == @category.name
  				@flag = 1
  			elsif (@flag == 0)
  				@flag = 0
  			end
  		end
  		if @flag == 0
	  		
	  		@events_all.each do |event|
	  			if event.category == @category && !@user_events.include?(event) && event.stop_date >= @date
	  				@recommended_by_category_name << event
	  			end
	  		end
  		
  			@tab_recommended_category_count_similar << [@category.name, @user_events.where(:category_id => @category.id).count, @recommended_by_category_name]
  		end
  		
  	end
  	@tab_recommended_category_count_similar.sort{|a,b| b[1] <=> a[1]} 
	
  	#### Wyszukiwanie ze wzgledu na TAGI cieszace sie zainteresowaniem ####
  	@user_tags = Array.new
  	@common_tags = Array.new
  	@user_events.each do |event|
  		event.tags.each do |tag|
  			if !@user_tags.include?(tag)
  				@user_tags << tag
  			end
  		end
  	end
  	
  	@events_all.each do |event|
  		if !@user_events.include?(event) && event.stop_date >= @date
  			@common_tags = Array.new
  			@event_tags = event.tags
  			@event_tags.each do |event_tag|
  				if @user_tags.include?(event_tag)
  					@common_tags << event_tag
  				end
  			end
  			if @common_tags.count >0
  				@recommended_by_tags_id << [event, @common_tags.count, @common_tags]
  			end
  		end
  	end 	
  	
  						
  end
  
  def events_same_time
    
    @event = Event.find(params[:id])
    @events_start = Event.find(:all, :conditions => ["start_date >= ? AND start_date < ? AND id != ?", @event.start_date, @event.stop_date, @event.id])
    @events_stop = Event.find(:all, :conditions => ["stop_date <= ? AND stop_date > ? AND id != ?", @event.stop_date, @event.start_date, @event.id])
    
    @events = @events_start + @events_stop
    @events = @events.uniq
    respond_to do |format|
      format.html # events_same_time
      format.json { head :ok }
    end
    
  end 	
  	
   
end
