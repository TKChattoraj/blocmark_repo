class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :bookmark#, class_name: 'Bookmark', foreign_key: 'bookmark_id'

  validates :user, :bookmark, presence: true
  # validation uniqueness scoped to this pair
  validates :user, uniqueness: {scope: :bookmark, message: "only one like for user-bookmark pair"}
  validates :bookmark, uniqueness: {scope: :user, message: "only one like for user-bookmark pair"}
end
