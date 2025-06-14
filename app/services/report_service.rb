require 'csv'

class ReportService
  def initialize(user_id)
    @user = User.find(user_id)
  end

  def generate
    tweets = @user.tweets.recent
    CSV.generate(headers: true) do |csv|
      csv << ['Content', "Date"]
      tweets.each do |tweet|
        csv << [tweet.body, tweet.created_at.strftime("%d/%m/%Y %H:%M")]
      end
    end
  end
end