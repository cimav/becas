class Staff < SaposModels
  has_many :scholarship_comments, as: :person

  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end