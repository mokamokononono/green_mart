class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index_ordered_item
  before_action :move_to_index_myself_item

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      stock_item
      redirect_to items_path
    else
      render 'index'
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:zip_code, :prefecture_id, :city, :address, :building, :phone_number).merge(
      token: params[:token], user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def stock_item
    update_stock = @item.stock
    update_stock -= 1
    @item.update_attributes(stock: update_stock)
  end

  def move_to_index_myself_item
    redirect_to root_path if current_user.id == @item.user.id
  end

  def move_to_index_ordered_item
    redirect_to root_path unless @item.stock != 0
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end
