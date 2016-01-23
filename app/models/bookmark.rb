class Bookmark < ActiveRecord::Base
  belongs_to :topic
  URL_REGEX = /\A((https?:\/\/)|(www.))[\w]+\.com\z/i
  validates :url,
            presence: true,
            uniqueness: {case_sensative: false},
            format:  {with: URL_REGEX}
  validates :topic,
            presence: true
  # validates :topic_id,
  #           presence: true,
  #           inclusion: {in: Topic.ids, message:  "Bookmark does not have a valid topic"}

end
