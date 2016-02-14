class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :likes, dependent: :destroy
  has_many :bookmarks, through: :likes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :user_name

  def liked(bookmark)
    likes.where(bookmark_id: bookmark).first
  end

end
