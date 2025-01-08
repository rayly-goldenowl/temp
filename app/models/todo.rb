class Todo < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, completed: 1 }, _default: "pending"
  enum priority: { low: 0, medium: 1, high: 2 }

  validates :title, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates :priority, inclusion: { in: priorities.keys }
end
