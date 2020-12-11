class Map < ApplicationRecord
  belongs_to :article
  geocoded_by :address
  after_validation :geocode
end
