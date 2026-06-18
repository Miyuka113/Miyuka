class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    current_user.likes.create(tweet_id: tweet.id)

    redirect_to tweets_path(anchor: "tweet-#{tweet.id}"), status: :see_other
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    like = current_user.likes.find_by(tweet_id: tweet.id)
    like&.destroy

    redirect_to tweets_path(anchor: "tweet-#{tweet.id}"), status: :see_other
  end
end