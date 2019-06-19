# encoding: utf-8
class StudentFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{ENV['SAPOS_DIR']}/private/files/students/#{model.student_id}"
  end

  def filename
    original_filename.gsub(/ /i,'_').gsub(/[^\.a-z0-9_]/i, '') if original_filename
  end

end