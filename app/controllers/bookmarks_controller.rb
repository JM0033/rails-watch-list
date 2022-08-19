class BookmarksController < ApplicationController
before_action :set_list, only: %i[new create]
# before_action :set_movie, only: %i[destroy]

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    @bookmark.list = @list
    if @bookmark.valid?
      @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    @list = @bookmark.list
    @bookmark.destroy
    redirect_to list_path(@list)
  end

  private
  def set_list
    @list = List.find(params[:list_id])
  end

  def set_movie
  @bookmark.movie = Movie.find(params[:bookmark][:movie_id])
  end

  def bookmark_params
    params.require(:bookmark).permit(:movie_id, :list_id, :comment)
  end
end
