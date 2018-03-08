class Staff < SaposModels
  has_many :scholarship_comments, as: :person
  has_many :supervised, :class_name => "Student", :foreign_key => :supervisor

  ACTIVE    = 0
  INACTIVE = 1


  def full_name
    "#{self.first_name} #{self.last_name}"
  end
end