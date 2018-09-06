# encoding: utf-8
class ScholarshipFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "#{Rails.root}/private/#{model.class.to_s.underscore}/#{model.scholarship.id}"
  end

  def filename
    original_filename.gsub(/ /i,'_').gsub(/[^\.a-z0-9_]/i, '') if original_filename
  end

end