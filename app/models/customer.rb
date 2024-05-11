class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :customer_image
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  # (フォロー機能）
  # フォローしている関連付け
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

  # フォローされている関連付け
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  # フォローしているユーザーを取得
  has_many :followings, through: :relationships, source: :followed

  # フォロワーを取得
  has_many :followers, through: :passive_relationships, source: :follower

  # 指定したユーザーをフォローする
  def follow(customer_id)
    relationships.create(followed_id: customer_id)
  end

  # 指定したユーザーのフォローを解除する
  def unfollow(customer_id)
    relationships.find_by(followed_id: customer_id).destroy
  end

  # 指定したユーザーをフォローしているかどうかを判定
  def following?(customer)
    followings.include?(customer)
  end


  #ゲストユーザー
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

  # 顧客画像
  def get_customer_image(width, height)
    unless customer_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      customer_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    customer_image.variant(resize: "#{width}x#{height}!").processed
  end

  #検索方法分岐
  def self.looks(word)
    if word.present?
      @customers = Customer.where("name LIKE ?", "%#{word}%")
    else
      @customers = Customer.all
    end
  end
end
