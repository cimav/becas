class NotificationsController < ApplicationController

  def show
    notification = Notification.find(params[:id])
    notification.update(read:true)
    redirect_to "#{notification.link}?target=#{notification.target}"
  end

  def index
  end
end
