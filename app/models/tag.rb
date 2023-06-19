class Tag < ApplicationRecord

  has_many :post_tags, dependent: :destroy, foreign_key: 'tag_id'
  has_many :posts, through: :post_tags

  validates :name, presence: true, length: {maximum:15}

  # def self.search(search)
  #   if search != '#'
  #     tag = Tag.where(name: search)
  #     tag[0].posts
  #   else
  #     Post.all
  #   end
  # end

end
