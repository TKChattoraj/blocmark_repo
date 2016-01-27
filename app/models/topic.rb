class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks

  validates :title, presence: true
  # validates :users, presence: true
  # This is a placeholder and will be replaced in the next commit
end
