# Just a chat
class Chat < ActiveRecord::Base
  belongs_to :human

  validates :text, presence: true, length: { maximum: 250 }
end
