class ContentcommentsController < ApplicationController
  def create
    @contentcomment = Contentcomment.new(contentcomment_params)
    if @contentcomment.save
    else
      @content = Content.find(params[:content_id])
      @contentcomments = @content.contentcomments

    end
    redirect_to content_path(@contentcomment.content.id)
  end

  private

  def contentcomment_params
    params.require(:contentcomment).permit(:text).merge(user_id: current_user.id, content_id: params[:content_id])
  end
end
