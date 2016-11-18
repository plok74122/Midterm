class EventCommentsController < ApplicationController
	before_action :find_event

  def index
    @comments = @event.comments
  end

  def show
    @comment = @event.comments.find( params[:id] )
  end

  def new
    @comment = @event.comments.build
  end

  def create
    @comment = @event.comments.build( comment_params )
    @comment.user = current_user
    
    if @comment.save
      flash[:notice] = "comment was successfully created"
      redirect_to event_url( @event )
    else
      render "events/show"
    end
  end

  def edit
    @comment = @event.comments.find( params[:id] )
  end

  def update
    @comment = @event.comments.find( params[:id] )
    @comment.user = current_user
    if @comment.update( comment_params )
      flash[:notice] = "comment was successfully updated"
      redirect_to event_url( @event )
    else
      render :action => :edit
    end
  end 

  def destroy
    @comment = @event.comments.find( params[:id] )
    @comment.destroy 
    flash[:alert] = "comment was successfully deleted"
    redirect_to event_url( @event )
  end

  protected

  def find_event
    @event = Event.find( params[:event_id] )
  end

  def comment_params
  	params.require(:comment).permit(:comment_text)
  end
end
