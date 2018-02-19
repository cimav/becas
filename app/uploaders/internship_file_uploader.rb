# encoding: utf-8
class InternshipFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "../sapos/private/files/internships/#{model.internship_id}"
  end

end