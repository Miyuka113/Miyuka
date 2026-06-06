class TweetsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @tweets = Tweet.all

    if params[:search].present?
      search = params[:search]
      @tweets = @tweets.where(
        "title LIKE ? OR place LIKE ? OR genre LIKE ?",
        "%#{search}%",
        "%#{search}%",
        "%#{search}%"
      )
    end

    if params[:tag_ids].present?
      @tweets = @tweets.joins(:tags)
                       .where(tags: { id: params[:tag_ids] })
                       .distinct
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id

    if tweet.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
    @tweet = Tweet.find(params[:id])

    @comments = @tweet.comments
    @comment = Comment.new

  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    tweet = Tweet.find(params[:id])

    if tweet.update(tweet_params)
      redirect_to action: :show, id: tweet.id
    else
      render :new
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to action: :index
  end

  def favorites
    @tweets = current_user.liked_tweets
  end

  private

  def tweet_params
    params.require(:tweet).permit(
      :place,
      :title,
      :people,
      :budget,
      :genre,
      :image,
      tag_ids: []
    )
  end

end