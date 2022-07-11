class Public::AddressesController < ApplicationController
  def index
    @address = Address.new
    @addresses = Address.all
  end

  def edit
    @address = Address.find(params[:id])
  end
  
  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    @addresses = Address.all
    redirect_to public_addresses_path
  end
  
  def update
   @addresses = Address.all
   @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "変更内容を更新しました。"
      redirect_to public_addresses_path
    else
      flash[:alert] = "変更内容に不備があります。"
      render "edit"
    end
  end
  
  private

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
