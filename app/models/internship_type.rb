class InternshipType < SaposModels
  has_many :internships

  def full_name
    "#{id}: #{name}" rescue name
  end

end