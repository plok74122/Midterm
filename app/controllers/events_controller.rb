class EventsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_events, :only =>[ :show, :edit, :update, :destroy]
	before_action :event_value, :only => [:index]
	def index
		@events = Event.all 
		#page(params[:page]).per(5)
   		# @categories = Category.all
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@events =Event.all
		#@event.user = current_user
		if @event.save
			flash[:notice] = "災情信息成功發布"
			redirect_to events_url
		else
		# @categories = Category.all 
			render 'index'	
		end	
	end

	def show
		@page_title = @event.title
		# @comments = @event.comments
		# if params[:edit_comment]
		# 	@comment = @event.comments.find([params[:edit_comment]])
		# else
		# 	@comment = Comment.new
		# end	
	end
	
	def edit		
	end

	def update
		if @event.update(event_params)
			flash[:notice] = "災情信息發布成功"
			redirect_to event_url(@event)
		else 
			render :edit 
		end		
	end	

	def destroy
		@event.destroy
		flash[:alert] = "災情信息已經刪除"
		redirect_to events_url
	end 

	private
	
	def event_params
		params.require( :event ).permit( :title, :description)#, :category_id,  :category_ids => [] )
	end	 	

	def set_events
		@event = Event.find(params[:id])
	end
		
	def event_value
		unless @event 
			@event = Event.new
		end	 	
	end		
end
