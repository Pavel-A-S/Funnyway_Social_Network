# Just a photo gallery
class PhotoGallery < ActiveRecord::Base
  include SharedModelMethods

  belongs_to :human
  has_many :photos, dependent: :destroy

  validates :description, presence: true, length: { maximum:  150 }
end
