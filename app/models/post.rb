class Post < ApplicationRecord
  has_one_attached :post_image
  # bilongs_to :user
end
