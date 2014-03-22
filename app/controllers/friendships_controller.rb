class FriendshipsController < ApplicationController
  before_action :require_login

  def create
    @friendship = current_user.friendships.create!(:friend_id => params[:friend_id])
    redirect_to :back, notice: "Added friend."
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    redirect_to :back, notice: "Removed friendship."
  end

  private
  def comment_params
    params.require(:friendship).permit(:friend_id)
  end
end
