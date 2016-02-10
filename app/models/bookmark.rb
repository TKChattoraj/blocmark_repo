class Bookmark < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :likes
  has_many :users, through: :likes

  URL_REGEX = /\A((https?:\/\/)|(www.))[\w]+\.com\z/i
  validates :url,
            presence: true,
            uniqueness: {case_sensative: false},
            format:  {with: URL_REGEX}
  validates :topic,
            presence: true
  validates :user,
            presence: true

  # validates :topic_id,
  #           presence: true,
  #           inclusion: {in: Topic.ids, message:  "Bookmark does not have a valid topic"}

end
