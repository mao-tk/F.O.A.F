class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :posts,    dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :folders,   dependent: :destroy

  has_one_attached :profile_image

  validates :name, presence: true, length: {maximum:10}

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no-image.png')
      profile_image.attach(io: File.open(file_path), filename: 'no-image.png', content_type: 'image/png')
    end
    profile_image.variant(resize_to_limit:[width, height]).processed
  end

  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def active_for_authentication?
    super && (is_deleted == false)
  end


end
