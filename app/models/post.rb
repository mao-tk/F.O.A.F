class Post < ApplicationRecord

  belongs_to :user
  belongs_to :area , optional: true

  has_many :bookmarks, dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  enum status: { public:0, private:1 }, _prefix: true

  has_one_attached :post_image

  def get_post_image(width, height)
    # unless profile_image.attached?
    #   file_path = Rails.root.join('app/assets/images/no-image.jpg')
    #   profile_image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
    # end
    post_image.variant(resize_to_limit:[width, height]).processed
  end

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name:old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name:new)
      self.tags << new_post_tag
    end
  end

  def self.search(search)
      return all unless search
      where(['title LIKE ?', "%#{search}%"]).or(where('body LIKE?', "%#{search}%"))
  end

end
