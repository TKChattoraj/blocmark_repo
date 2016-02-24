class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks

  validates :title, presence: true

  def liked_bookmarks
    topic_bookmarks = self.bookmarks
    liked_bookmarks = []
    Like.all.each do |l|
      liked_bookmarks << Bookmark.find(l.bookmark_id)
    end
    liked_bookmarks & topic_bookmarks
  end
  #
  # def some_other_method
  #   liked_bookmarks
  # end
end
#
# t = Topic.last
# t.some_other_method
