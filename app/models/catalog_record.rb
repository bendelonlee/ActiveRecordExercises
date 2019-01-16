class CatalogRecord < ActiveRecord::Base
  self.abstract_class = true
  establish_connection :"catalog_#{Rails.env}"
end
