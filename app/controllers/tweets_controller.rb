class TweetsController < ApplicationController
  def index
    per_page = (params[:per_page] || 10).to_i
    cursor = params[:cursor]

    tweets = Tweet.order(created_at: :desc)
    tweets = tweets.where('created_at < ?', Time.at(cursor.to_i)) if cursor.present?

    tweets.limit(per_page)
    next_cursor = tweets.last&.created_at&.to_i

    render json: {
      tweets: tweets,
      next_cursor: (tweets.size == per_page ? next_cursor : nil)
    }
  end
end
