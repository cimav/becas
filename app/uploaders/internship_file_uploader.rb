# encoding: utf-8
class InternshipFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{ENV['SAPOS_DIR']}/private/files/internships/#{model.internship_id}"
  end

  def filename
    original_filename.gsub(/ /i,'_').gsub(/[^\.a-z0-9_]/i, '') if original_filename
  end

end