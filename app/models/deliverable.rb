class Deliverable < ApplicationRecord
	belongs_to :owner, class_name: 'User'

	mount_uploader :image, ImageUploader
	mount_uploader :cover, ImageUploader

	has_one :menu , :as => :menuable , dependent: :destroy
	has_many :reviews , :as => :reviewable , dependent: :destroy
	has_many :orders , :as => :ordera  , dependent: :destroy
	has_many :branches  , dependent: :destroy

	enum status: [:pending , :approved , :block]
	enum order_status: [:quiet , :moderate , :busy]

	belongs_to :deliver_category

	scope :approved, lambda {where(:status => 'approved')}
	scope :popular, lambda {where(:popular => true)}

	scope :highest_rated, lambda {where("deliverables.id in (select id from deliverables)").group('deliverables.id').joins(:reviews).order('AVG(reviews.rating) DESC')}

end
