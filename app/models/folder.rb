class Folder < ApplicationRecord

  belongs_to :user
  has_many :bookmarks, dependent: :destroy

  validates :name, length: { in: 1..15 }

end
