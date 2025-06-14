class Tweet < ApplicationRecord
  belongs_to :user

  scope :recent, -> { order(created_at: :desc) }
  scope :before_cursor, ->(cursor) { 
    where('created_at < ?', Time.at(cursor.to_i)) if cursor.present?
  }
  scope :by_username, ->(username) {
    joins(:user).where(users: { username: username }) if username.present?
  }
  scope :paginate, ->(per_page) { limit(per_page) if per_page.present? }
end
