class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end
  def edit
    @customer = Customer.find(params[:id])
  end
  def show
    @customer = Customer.find(params[:id])
  end
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "変更内容を更新しました。"
      redirect_to admin_customers_index_path
    else
      flash[:alert] = "変更内容に不備があります。"
      render "index"
    end
  end

  private

  def customer_params
    params.require(:customer).permit(
      :email, :is_deleted, :last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number)
  end
end