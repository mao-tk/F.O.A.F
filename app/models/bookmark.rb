class Bookmark < ApplicationRecord

  belongs_to :post
  belongs_to :folder
  belongs_to :user

end
