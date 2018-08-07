module UsersHelper

  def notifications
    current_person.notifications.order(created_at: :desc)
  end

end
