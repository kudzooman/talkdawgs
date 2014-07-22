class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :posts
  has_many :comments
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  def self.top_rated
    self.select('users.*'). #Select all attributes of the user
    select('COUNT(DISTINCT comments.id) AS comments_count'). # count the comments made by user
    select('COUNT(DISTINCT posts.id) AS posts_count'). # count the posts made by user
    select('COUNT(DISTINCT comments.id) + COUNT(DISTINCT posts.id) AS rank'). # Add the comment count to the post count and label sum as "rank"
    joins(:posts). # ties the posts table to the users table, via the user_id 
    joins(:comments). # ties the comments table to the users table, via user_id
    group('users.id'). #Instructs the database to group the results so that each user will be returned ina distinct row
    order('rank DESC') # Instructs the database to order the results in descending order, by the rank we created in this query. ( rank = comment + post count)
  end

  def favorited(post)
    self.favorites.where(post_id: post.id).first
  end

  def role?(base_role)
   role == base_role.to_s
  end

  def voted(post)
    self.votes.where(post_id: post.id).first
  end
end
