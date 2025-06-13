class TweetsController < ApplicationController
  before_filter :set_tweets

  def index
    per_page = (params[:per_page] || 10).to_i
    cursor = params[:cursor]

    @tweets = @tweets.where('created_at < ?', Time.at(cursor.to_i)) if cursor.present?
    
    @tweets = @tweets.limit(per_page)
    next_cursor = @tweets.last&.created_at&.to_i

    render json: {
      tweets: @tweets,
      next_cursor: (@tweets.size == per_page ? next_cursor : nil)
    }
  end

  private

  def set_tweets
    if params[:user_username]
      user = User.find_by(username: params[:user_username])
      @tweets = user.tweets.order(created_at: :desc)
    else
      @tweets = Tweet.order(created_at: :desc)
    end
  end
end
