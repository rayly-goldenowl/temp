class Todo < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, completed: 1 }
  enum priority: { low: 0, medium: 1, high: 2 }

  validates :title, presence: true
  validates :status, inclusion: { in: statuses.keys }
  validates :priority, inclusion: { in: priorities.keys }

  after_initialize :set_default_status, if: :new_record?

  private

  def set_default_status
    self.status ||= :pending
  end
end
