class LinksController < ApplicationController
  def new
    @link = Link.new
    authorize @link
  end

  def create
    @link = Link.new(links_params)
    @link.user = current_user
    authorize @link
    if @link.save
      redirect_to profile_path(current_user)
    else
      render 'new'
    end
  end

  def destroy
    @link = Link.find(params[:id])
    authorize @link
    @link.destroy
    redirect_to profile_path(current_user)
  end

  private

  def links_params
    params.require(:link).permit(:title, :url)
  end
end
