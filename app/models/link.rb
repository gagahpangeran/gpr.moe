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

  def increment_visit_count
    increment!(:visit_count)

    daily_visit = daily_visits.find_or_initialize_by(visited_at: Date.current)
    daily_visit.count += 1
    daily_visit.save!
  end

  def daily_visits_chart_data(start_date: nil, end_date: nil)
    end_date ||= Date.current
    start_date ||= [ created_at.to_date, end_date - 7.days ].max

    data = daily_visits.where(visited_at: start_date..end_date)
                        .group(:visited_at)
                        .sum(:count)

    (start_date..end_date).map { |date| [ date, data[date] || 0 ] }
  end

  private
    def reset_visit_count
      self.visit_count = 0
      self.daily_visits.destroy_all
    end
end
