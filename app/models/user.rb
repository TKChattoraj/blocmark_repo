class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  has_many :likes, dependent: :destroy
  has_many :liked_bookmarks, through: :likes, source: :bookmark
  has_many :bookmarks#, class_name: 'Bookmark', foreign_key: 'other_user_id'
  # def zebras
  #   Zebra.where(user_id: self.id)
  # end
  # @user.bookmarks
  # @user.liked_bookmarks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :user_name

  def liked(bookmark)
    likes.where(bookmark_id: bookmark).first
  end

end
