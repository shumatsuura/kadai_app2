class FeedsController < ApplicationController
  before_action :set_feed, only:[:edit,:show,:update,:destroy]

  def index
    @feeds = Feed.all
  end

  def new
    @feed = Feed.new
  end

  def create
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    if params[:back]
      render 'new'
    else
      if @feed.save
        redirect_to feeds_path, notice:"投稿しました。"
      else
        render 'new'
      end
    end
  end

  def confirm
    @feed = Feed.new(feed_params)
    @feed.user_id = current_user.id
    render 'new' if @feed.invalid?
  end

  def edit
  end

  def update
    if @feed.update(feed_params)
      redirect_to feeds_path, notice: "編集しました。"
    else
      render 'edit'
    end
  end

  def show

  end

  def destroy
    @feed.destroy
    redirect_to feeds_path, notice:"削除しました"
  end


  private

  def feed_params
    params.require(:feed).permit(:image,:image_cache, :content)
  end

  def set_feed
    @feed = Feed.find_by(id: params[:id])
  end
end
