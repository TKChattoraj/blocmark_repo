class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark#, class_name: 'Bookmark', foreign_key: 'bookmark_id'

  validates :user, :bookmark, presence: true
  # validation uniqueness scoped to this pair
end
