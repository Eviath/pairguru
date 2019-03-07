class CommentsController < ApplicationController
  before_action :set_user
  before_action :set_movie, only: [:create, :destroy]

  def create
    # create comment associated with user
    @comment = @movie.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment created successfully"
      redirect_to movie_path(@movie)
    else
      @comment.errors.full_messages.each do |message|
        flash[:danger] = message
      end
      redirect_to movie_path(@movie)
    end
  end

  def destroy
    @comment = @movie.comments.find(params[:id])
    @comment.destroy
    redirect_to movie_path(@movie)
    flash[:notice] = "Comment deleted successfully"
  end


  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end

  def set_user
    @user = current_user
  end



  # we do not trust NOT whitelisted params
  def comment_params
    params.require(:comment).permit(:movie_id, :content).merge({user_id: current_user.id})
  end


end


