class Post < ApplicationRecord
  has_one_attached :post_image
  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  def get_post_image
    unless post_image.attached?
      file_path = Rails.root.join('app/assets/images/neko.jpg')
      post_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    post_image
  end


  def favorited_by?(customer)
    favorites.exists?(customer_id: customer.id)
  end

 #検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("caption LIKE?","#{word}")
    elsif search == "forward_match"
      @post = Post.where("caption LIKE?","#{word}%")
    elsif search == "backward_match"
      @post = Post.where("caption LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("caption LIKE?","%#{word}%")
    else
      @post = Post.all
    end
  end

end
