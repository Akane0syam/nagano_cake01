class Admin::GenresController < ApplicationController
  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "変更内容を更新しました。"
      redirect_to admin_genres_path
    else
      flash[:alert] = "変更内容に不備があります。"
      render "edit"
    end
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    @genres = Genre.all
    # redirect_to admin_genres_path
    redirect_to :index
  end

   private
  # ストロングパラメータ
  def genre_params
    params.require(:genre).permit(:name)
  end
end
