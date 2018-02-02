json.extract! scholarship_type, :id, :name, :description, :category, :max_amount, :created_at, :updated_at
json.url scholarship_type_url(scholarship_type, format: :json)
