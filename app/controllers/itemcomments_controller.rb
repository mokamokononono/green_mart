class ItemcommentsController < ApplicationController
  def create
    @itemcomment = Itemcomment.new(itemcomment_params)
    if @itemcomment.save
    else
      @item = Item.find(params[:item_id])
      @itemcomments = @item.itemcomments

    end
    redirect_to item_path(@itemcomment.item.id)
  end

  private

  def itemcomment_params
    params.require(:itemcomment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
