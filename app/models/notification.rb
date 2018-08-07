class Notification < ApplicationRecord
  belongs_to :person, polymorphic: true
  before_create :init_notification

  MESSAGE = 1
  ADMIN_NOTE = 2
  NEW_SCHOLARSHIP =3

  def target
    case self.notification_type
    when MESSAGE
      'messages'
    when ADMIN_NOTE
      'admin_notes'
    else
      ''
    end
  end

  def init_notification
    self.read = false
  end

end
