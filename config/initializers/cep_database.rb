CEP_DB = YAML.load_file(File.join(Rails.root, "config", "cep_database.yml"))[Rails.env.to_s]