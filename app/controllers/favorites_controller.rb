class FavoritesController < ApplicationController

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.build(post: @post) 

    if favorite.save
      flash[:notice] = "You like this huh? Good thing because you will now recieve emails regarding this post."
      redirect_to [@topic, @post]
    else
      flash[:error] = "No good. Try again."
      redirect_to [@topic, @post]
    end
    authorize favorite
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    favorite = current_user.favorites.find(params[:id])

    if favorite.destroy
      flash[:notice] = "Not nice no more?"
      redirect_to [@topic, @post]
    else
      flash[:error] = "That didn't work. Try harder."
      redirect_to [@topic, @post]
    end
    authorize favorite
  end
end