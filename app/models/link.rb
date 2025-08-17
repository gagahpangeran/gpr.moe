class Link < ApplicationRecord
  belongs_to :user
  has_many :daily_visits, dependent: :destroy

  validates :slug,
    presence: { message: "can not empty" },
    uniqueness: { case_sensitive: false, message: "already exists" }

  validates :slug,
    format: {
      with: /\A[a-zA-Z0-9_-]+\z/,
      message: "can only contains 'a-z', 'A-Z', '0-9', '-', and '_'."
    },
    unless: -> { slug == "/" }

  before_update :reset_visit_count
  scope :with_url, -> { where.not(url: nil) }

  default_scope { with_url }

  private
    def reset_visit_count
      self.visit_count = 0
    end
end
