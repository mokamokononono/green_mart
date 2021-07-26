class ContentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_content, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index_other_user, except: [:index, :new, :create, :show]

  def index
    @contents = Content.order('created_at DESC')
  end

  def new
    @content = Content.new
  end

  def create
    @content = Content.new(content_params)
    if @content.save
      redirect_to contents_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @content.update(content_params)
      redirect_to contents_path
    else
      render :edit
    end
  end

  def destroy
    @content.destroy
    redirect_to contents_path
  end

  private

  def content_params
    params.require(:content).permit(:title, :text, :image).merge(user_id: current_user.id)
  end

  def move_to_index_other_user
    redirect_to action: :index unless current_user.id == @content.user.id
  end

  def set_content
    @content = Content.find(params[:id])
  end
end
