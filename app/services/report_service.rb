require 'csv'

class ReportService

  def generate
    tweets = Tweet.recent
    CSV.generate(headers: true) do |csv|
      csv << ['Content', "Date"]
      tweets.each do |tweet|
        csv << [tweet.body, tweet.created_at.strftime("%d/%m/%Y %H:%M")]
      end
    end
  end
end