module ScholarshipsHelper
  def status_color(status)
    color = ''
    case status
      when Scholarship::REQUESTED
      color = 'orange-text text-lighten-2'
      when Scholarship::APPROVED
      color = 'blue-text text-lighten-2'
      when Scholarship::ACTIVE
      color = 'green-text'
      when Scholarship::INACTIVE
      color = 'grey-text'
    end
  end
end
