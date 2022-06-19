class Public::CustomersController < ApplicationController

  def edit
    @customer = Customer.find(params[:id])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def quit
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to public_customer_path
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(
      :email, :is_deleted, :last_name, :first_name, :last_name_kana,
      :first_name_kana, :postal_code, :address, :telephone_number)
  end
end
