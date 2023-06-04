class Post < ApplicationRecord

  belongs_to :user
  belongs_to :area

  has_many :bookmarks, dependent: :destroy
  has_many :comments,  dependent: :destroy
  has_many :post_tags, dependent: :destroy

  enum status: { public:0, private:1 }, _prefix: true

  has_one_attached :post_image

  def get_post_image(width, height)
    # unless profile_image.attached?
    #   file_path = Rails.root.join('app/assets/images/no-image.jpg')
    #   profile_image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
    # end
    post_image.variant(resize_to_limit:[width, height]).processed
  end

end
