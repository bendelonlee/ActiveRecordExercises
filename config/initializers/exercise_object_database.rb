DB_EXOB = YAML::load(ERB.new(File.read(Rails.root.join("config", "exob_database.yml"))).result)[Rails.env]
