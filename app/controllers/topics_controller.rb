class TopicsController < ApplicationController
   before_action :authenticate_user!, only: [:index, :new, :confirm, :create, :show]
  before_action :set_topic, only: [:edit, :update, :destroy, :show]
  def index
    @topics = Topic.order(created_at: :desc).all
  end
  
  #def confirm
  #  @topic = Topic.new(topics_params)
  #  render :new if @topic.invalid?
  #end

  def new

    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def create
    @topic = Topic.new(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
        redirect_to topics_path, notice: "投稿しました!"
        NoticeMailer.sendmail_topic(@topic).deliver
    else
        render action: 'new'
    end
  end

  def edit

  end

  def update

    if @topic.update(topics_params)
      redirect_to topics_path, notice: "更新しました!"
    else
    render action: 'edit'
    end
  end

  def destroy

    @topic.destroy
    redirect_to topics_path, notice: "投稿を削除しました!"
  end
  
  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
    Notification.find(params[:notification_id]).update(read: true) if params[:notification_id]
  end

  private
  def topics_params
    params.require(:topic).permit( :content, :image)
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end
