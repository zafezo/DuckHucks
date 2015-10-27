class Event < ActiveRecord::Base
	belongs_to :user
	has_many :members
	belongs_to :category
 # add geolocation
	geocoded_by :address
	after_validation :geocode 


	def address_schort
	  [street, city, state, country].compact.join(', ')
	end

def self.search(search)
  where("what LIKE ?", "%#{search}%") 
  # where("content LIKE ?", "%#{search}%")
end
end
