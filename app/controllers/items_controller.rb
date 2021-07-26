class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index_other_user, except: [:index, :new, :create, :show]
  before_action :move_to_index_ordered_item, except: [:index, :new, :create, :show]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to items
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :amount, :stock, :description, :image, :category_id, :condition_id, :pesticides_id, :shipping_charge_id,
                                 :shipping_source_id, :shipping_date_id).merge(user_id: current_user.id)
  end

  def move_to_index_other_user
    redirect_to action: :index unless current_user.id == @item.user.id
  end

  def move_to_index_ordered_item
    redirect_to action: :index unless @item.stock != 0
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
