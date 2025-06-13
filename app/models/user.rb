class User < ApplicationRecord
  belongs_to :company

  scope :by_company, -> (company_id) { where(company: company_id) if company_id.present? }
  scope :by_username, -> (username) { 
    where('username ILIKE ?', "%#{username}%") if username.present? 
  }

  after_create :send_welcome_email

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end
end
