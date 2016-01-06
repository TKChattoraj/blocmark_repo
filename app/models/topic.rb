class Topic < ActiveRecord::Base
  belongs_to :user
  has_many :bookmarks

  validates :title, presence: true
end
