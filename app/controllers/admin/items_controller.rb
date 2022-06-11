class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  def new
    @item = Item.new
  end
  def show
    @item = Item.find(params[:id])
  end
  def edit
    @item = Item.find(params[:id])
  end
  def create
    @item = Item.new(item_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    @item.save
    # 4. トップ画面へリダイレクト
    redirect_to '/admin/items'
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "変更内容を更新しました。"
      redirect_to admin_item_path
    else
      flash[:alert] = "変更内容に不備があります。"
      render "edit"
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :image, :price, :genre_id, :is_active)
  end
end
