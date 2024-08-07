class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :post_image, presence: true
  validates :caption, presence: true

# 投稿
  def get_post_image(width, height)
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/neko.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image.variant(resize: "#{width}x#{height}!").processed
  end

  # お気に入り機能
  def favorited_by?(customer)
    if customer
      favorites.exists?(customer_id: customer.id)
    else
      false
    end
  end

  #退会者のコメント非表示
  def comment_by_not_deleted_user_count
    post_comments.joins(:customer).where(customer: {is_active: true}).count
  end

 #検索方法分岐
  def self.looks(word)
    if word.present?
      Post.where("caption LIKE ?", "%#{word}%")
    else
      Post.all
    end
  end

end
