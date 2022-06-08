class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all
  end
  def new
    @item = Item.new
  end
  def show
    @items = Item.find(params[:id])
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
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :image, :price, :genre_id)
  end
end
