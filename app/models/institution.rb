class Institution < SaposModels
  has_many :staffs

  def full_name
    "#{name} (#{short_name})" rescue ''
  end

end