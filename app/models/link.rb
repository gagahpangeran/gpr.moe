class Link < ApplicationRecord
  belongs_to :user

  validates :slug, presence: { message: "can not empty" },
                    uniqueness: { case_sensitive: false, message: "already exists" }

  before_update :reset_visit_count

  private
    def reset_visit_count
      self.visit_count = 0
    end
end
