class Topics::PostsController < ApplicationController

  def show
    @topic = Topic.find(params[:topic_id])
    authorize @topic
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    authorize @comment, :new?
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
    authorize @post
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = current_user.posts.build(post_params)
    @post.topic = @topic

    authorize @post 
    if @post.save
      redirect_to [@topic, @post], notice: "Bam!"
    else
      flash[:error] = "What was that?! Try again."
      render :new
    end
  end

  def update
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])
    authorize @post
    if @post.update_attributes(post_params)
      flash[:notice] = "Good stuff!"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Ruh roh! Error! Try again, this time do it right."
      render :new
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:id])

    title = @post.title
    authorize @post
    if @post.destroy
      flash[:notice] = "\"#{title}\" is no more. I hope you are happy."
      redirect_to @topic
    else
      flash[:error] = "Oh no! That did NOT work."
      render :show
    end
  end

private

def post_params
  params.require(:post).permit(:title, :body, :images)
end

end
