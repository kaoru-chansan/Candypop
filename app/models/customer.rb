class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :customer_image
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy

  GUEST_CUSTOMER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_CUSTOMER_EMAIL) do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestcustomer"
    end
  end

  def guest_customer?
    email == GUEST_CUSTOMER_EMAIL
  end

  def get_customer_image(width, height)
    unless customer_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      customer_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    customer_image.variant(resize: "#{width}x#{height}!").processed
  end
end
