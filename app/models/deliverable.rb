class Deliverable < ApplicationRecord
	belongs_to :owner, class_name: 'User'

	mount_uploader :image, ImageUploader
	mount_uploader :cover, ImageUploader
	
	geocoded_by :location do |obj,results|
	  if geo = results.first
	    obj.latitude    = geo.latitude
	    obj.post_code = geo.postal_code
	    obj.longitude    = geo.longitude
	  end
	end
	after_validation :geocode 

	has_one :menu , :as => :menuable , dependent: :destroy
	has_many :reviews , :as => :reviewable , dependent: :destroy
	has_many :orders , :as => :ordera  , dependent: :destroy

	enum status: [:pending , :approved , :block]
	enum order_status: [:quiet , :moderate , :busy]

	belongs_to :deliver_category

	scope :approved, lambda {where(:status => 'approved')}
	scope :popular, lambda {where(:popular => true)}

end
