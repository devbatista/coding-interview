class TweetsController < ApplicationController
  
  def index
    per_page = (params[:per_page] || 10).to_i
    cursor = params[:cursor]
    username = params[:user_username]

    @tweets = Tweet.recent
                   .by_username(username)
                   .before_cursor(cursor)
                   .paginate(per_page)

    @next_cursor = @tweets.last&.created_at&.to_i
  end
end
