class DailyVisit < ApplicationRecord
  belongs_to :link

  validates :visited_at, presence: true
  validates :count, numericality: { greater_than_or_equal_to: 0 }
end
