class CommentsController < ApplicationController
  
  
  def create
    # Blogをパラメータの値から探し出し,Blogに紐づくcommentsとしてbuildします。
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic
    @notification = @comment.notifications.build(user_id: @topic.user.id )
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
        format.js { render :index }
       unless @comment.topic.user_id == current_user.id
          Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'comment_created', {
            message: 'あなたの作成したブログにコメントが付きました'
          })
        end
        Pusher.trigger("user_#{@comment.topic.user_id}_channel", 'notification_created', {
          unread_counts: Notification.where(user_id: @comment.topic.user.id, read: false).count
        })
      else
        format.html { render :new }
      end
    end
  end

  def destroy
    #@topic = Blog.find(params[:id])
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
    respond_to do |format|
      @comment.destroy
      format.html { redirect_to topic_comment_path(@topic), notice: 'コメントを削除しました。' }
      format.js { render :index }
    end
  end
  
  def edit
    @comment = Comment.find(params[:id])
    @topic = @comment.topic
  end
  
    def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      @comment.update(comment_params)
      format.html { redirect_to topics_path(@comment.topic), notice: "コメントを更新しました!"}
   #  format.js { render :index }
    end
  end
  
  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
end
