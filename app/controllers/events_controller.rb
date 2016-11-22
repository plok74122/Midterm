class EventsController < ApplicationController
	before_action :authenticate_user!
	# set event 單數
	before_action :set_event, :only =>[:show]
	before_action :event_value, :only => [:index]
	before_action :set_own_event, :only => [:update , :edit , :destroy]
	def index
		@events = Event.includes(:comments , :user, :category).page(params[:page]).per(5)
		# 這一行在view裡面完全沒用到
		# @categories = Category.all
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		@events =Event.includes(:comments , :user, :category).page(params[:page]).per(5)
		@event.user = current_user
		if @event.save
			flash[:notice] = "災情信息成功發布"
			redirect_to events_url
		else
			# 這一行在view裡面完全沒用到
		 # @categories = Category.all
			render :action => :index	
		end	
	end

	def show
		@page_title = @event.title
		@comments = @event.comments
		if params[:edit_comment]
			# 缺少後端驗證
			@comment = current_user.comments.find([params[:edit_comment]])
		else
			@comment = Comment.new
		end	
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
		params.require( :event ).permit( :title, :description, :category_id,  :category_ids => [] )
	end	 	

	def set_event
		@event = Event.find(params[:id])
	end
		
	def event_value
		unless @event 
			@event = Event.new
		end	 	
	end

	def set_own_event
		# 確保event的使用者是current_user
		@event = current_user.events.find(params[:id])
	end
end
