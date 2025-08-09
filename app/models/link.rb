class Link < ApplicationRecord
  belongs_to :user

  validates :slug, presence: { message: "can not empty" },
                    uniqueness: { case_sensitive: false, message: "already exists" }
end
