class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    tweet = Tweet.find(params[:tweet_id])
    comment = tweet.comments.build(comment_params)
    comment.user_id = current_user.id

    if comment.save
      flash[:success] = "コメントしました"
    else
      flash[:success] = "コメントできませんでした"
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    comment = Comment.find(params[:id])

    if comment.user == current_user
      comment.destroy
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end